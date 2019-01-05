import 'dart:convert';
import 'package:flutter/material.dart';
import '../pages/NewsDetailPage.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import 'SlideViewIndicator.dart';

class SlideView extends StatefulWidget {
  int slideSize = 3;
  List slideData;
  SlideViewIndicator slideViewIndicator;

  SlideView(slideSize, indicator) {
    this.slideSize = slideSize;
    this.slideViewIndicator = indicator;
  }
  @override
  State<StatefulWidget> createState() {
    return new SlideViewState();
  }
}

class SlideViewState extends State<SlideView> with SingleTickerProviderStateMixin {
  

  TabController tabController;
  List slideData;

  @override
  void initState() {
    super.initState();
    getSlideList();

    slideData = this.widget.slideData;
    tabController = new TabController(length: slideData == null ? 0 : slideData.length, vsync: this);
    
    tabController.addListener(() {
      if (this.widget.slideViewIndicator.state.mounted) {
        this.widget.slideViewIndicator.state.setSelectedIndex(tabController.index);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget generateCard() {
    return new Card(
      color: Colors.blue,
      child: new Image.asset("images/ic_avatar_default.png", width: 20.0, height: 20.0,),
    );
  }

  getSlideList(){
    String url = Api.SLIDE_LIST;
    print(url);
    NetUtils.get(url).then((data) {
      if (data != null) {
        Iterable l = json.decode(data)['data'];
        List<Post> result = l.map((m) => Post.fromJson(m)).toList();
        if(result.length > 0) {
          setState(() {          
            slideData = result.sublist(0, widget.slideSize);
          });
        }
      }
    });
  }

  Future<Null> _pullToRefresh() async {
    getSlideList();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (slideData != null && slideData.length > 0) {
      for (var i = 0; i < slideData.length; i++) {
        var item = slideData[i];
        var imgUrl = item.imageLink;
        var title = item.title;
        var detailUrl = item.hrefLink;
        items.add(new GestureDetector(
          onTap: () {
            // 点击跳转到详情
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (ctx) => new NewsDetailPage(url: detailUrl, title: title,)
            ));
          },
          child: new Stack(
            children: <Widget>[
              new Image.network(imgUrl, width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth),
              new Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0x50000000),
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    title, 
                    style: new TextStyle(color: Colors.white, fontSize: 18.0,),
                    textAlign: TextAlign.center,
                  ),
                )
              )
            ],
          ),
        ));
      }
    }
//    items.add(new Container(
//      color: const Color(0x00000000),
//      alignment: Alignment.bottomCenter,
//      child: new SlideViewIndicator(slideData.length),
//    ));
    return new TabBarView(
      controller: tabController,
      children: items,
    );
    
    // Widget listView = TabBarView(
    //   controller: tabController,
    //   children: items,
    // );
    // return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
  }

}


class Post {
    final String title;
    final String thumbLink;
    final String imageLink;
    final String hrefLink;
    final String comments;
    final String postDate;

    Post({this.title, this.thumbLink, this.imageLink, this.hrefLink, this.comments, this.postDate, });

   factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      title: json['article_title'],
      thumbLink: json['media_avatar'],
      imageLink: json['article_image'],
      hrefLink: json['article_url'],
      comments: json['article_comments'].toString(),
      postDate: json['article_ctime'],
    );
   }
}
