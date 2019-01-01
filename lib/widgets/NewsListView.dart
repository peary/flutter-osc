import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import '../constants/Constants.dart';
import '../pages/NewsDetailPage.dart';
import '../widgets/CommonEndLine.dart';

class NewsList extends StatefulWidget {
  String tagID;
  
  NewsList({Key key, this.tagID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new NewsListState();
}

class NewsListState extends State<NewsList> {
  var listData;
  var curPage = 1;
  var listTotalSize = 0;

  final ScrollController _controller = new ScrollController();
  final TextStyle titleTextStyle = new TextStyle(fontSize: 16.0);
  final TextStyle subtitleStyle = new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 13.0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && listData.length < listTotalSize) {
        // scroll to bottom, get next page data
//        print("load more ... ");
        curPage++;
        getNewsList(true);
      }
    });
    getNewsList(false);
  }


  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // 无数据时，显示Loading
    if (listData == null) {
      return new Center(
        // CircularProgressIndicator是一个圆形的Loading进度条
        child: new CircularProgressIndicator(),
      );
    } else {
      // 有数据，显示ListView
      Widget listView = new ListView.builder(
        itemCount: listData.length * 2,
        itemBuilder: (context, i) => renderRow(i),
        controller: _controller,
      );
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  // 从网络获取数据，isLoadMore表示是否是加载更多数据
  getNewsList(bool isLoadMore) {
    String url = Api.NEWS_LIST;
    url += '&page=' + curPage.toString();
    if(widget.tagID != '' ) {
      url += '&tags=' + widget.tagID.toString();
    }
    print(url);
    NetUtils.get(url).then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Iterable l = json.decode(data);
        List<Post> result = l.map((m) => Post.fromJson(m)).toList();
        
        if (result.length > 0) {
          // code=0表示请求成功
          // total表示资讯总条数
          listTotalSize = 500;
          // data为数据内容，其中包含slide和news两部分，分别表示头部轮播图数据，和下面的列表数据
          
          setState(() {
            if (!isLoadMore) {              // 其他数据
              listData = result;
            } else {
              // 是加载更多，则需要将取到的news数据追加到原来的数据后面
              List newData = new List();
              // 添加原来的数据
              newData.addAll(listData);
              // 添加新取到的数据
              newData.addAll(result);
              // 判断是否获取了所有的数据，如果是，则需要显示底部的"我也是有底线的"布局
              if (newData.length >= listTotalSize) {
                newData.add(Constants.END_LINE_TAG);
              }
              // 给列表数据赋值
              listData = newData;
            }
          });
        }
      }
    });
  }

  Widget renderRow(i) {
    if (i.isOdd) {
      return new Divider(height: 1.0);
    }
    i = i ~/ 2;

    Post itemData = listData[i];
    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new CommonEndLine();
    }
    var titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(itemData.title, style: titleTextStyle),
        )
      ],
    );
    var timeRow = new Row(
      children: <Widget>[
        new Container(
          width: 20.0,
          height: 20.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFECECEC),
            image: new DecorationImage(
                image: new NetworkImage(itemData.thumbLink), 
                fit: BoxFit.cover
            ),
            border: new Border.all(
              color: const Color(0xFFECECEC),
              width: 2.0,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
          child: new Text(
            itemData.postDate,
            style: subtitleStyle,
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text(itemData.comments, style: subtitleStyle),
              new Image.asset('./images/ic_comment.png', width: 16.0, height: 16.0),
            ],
          ),
        )
      ],
    );
    var thumbImgUrl = itemData.thumbLink;

    var thumbImg;
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      thumbImg = new Container(
        margin: const EdgeInsets.all(6.0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(thumbImgUrl), 
              fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(8)),
          // border: new Border.all(
          //   color: const Color(0xFFECECEC),
          //   width: 2.0,
          // )
        ),
      );
    }
    var row;
    if(thumbImg == null) {
      row = new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new Column(
                children: <Widget>[
                  titleRow,
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0.0, 0.0),
                    child: timeRow,
                  )
                ],
              ),
            ),
          )
        ],
      );
    } else {
      row = new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new Column(
                children: <Widget>[
                  titleRow,
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0.0, 0.0),
                    child: timeRow,
                  )
                ],
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Container(
              width: 120.0,
              height: 90.0,
              child: new Center(
                child: thumbImg,
              ),
            ),
          )
        ],
      );
    }
    return new InkWell(
      child: row,
      borderRadius: new BorderRadius.all(Radius.circular(8)),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (ctx) => new NewsDetailPage(url: itemData.hrefLink, title: itemData.title,)
        ));
      },
    );
  }
}


class Post {
    final int id;
    final String title;
    final String thumbLink;
    final String imageLink;
    final String hrefLink;
    final String comments;
    final String postDate;

    Post({this.id, this.title, this.thumbLink, this.imageLink, this.hrefLink, this.comments, this.postDate, });

   factory Post.fromJson(Map<String, dynamic> json) {
    print(json.toString()); 
    return new Post(
      id: json['id'],
      title: json['title']['rendered'].toString(),
      thumbLink: json['post_thumbnail_image'],
      imageLink: json['post_large_image'],
      hrefLink: json['link'],
      comments: json['total_comments'].toString(),
      postDate: json['date'],
    );
   }
}