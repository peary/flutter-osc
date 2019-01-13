import 'dart:convert';
import 'package:flutter/material.dart';
import '../pages/NewsDetailPage.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import '../model/PostInfo.dart';
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
                    style: new TextStyle(color: Colors.white, fontSize: 16.0,),
                    textAlign: TextAlign.center,
                  ),
                )
              )
            ],
          ),
        ));
      }
    }
    
    return new TabBarView(
      controller: tabController,
      children: items,
    );
    
  }

}

