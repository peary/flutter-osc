import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import '../constants/Constants.dart';
import '../pages/NewsDetailPage.dart';
import '../widgets/CommonEndLine.dart';
import '../widgets/SlideView.dart';
import '../widgets/SlideViewIndicator.dart';
import '../widgets/MyDrawer.dart';
import '../widgets/NewsListView.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {

  SlideView slideView;
  SlideViewIndicator indicator;
  NewsList newsList;

  @override
  void initState() {
    super.initState();
    indicator = new SlideViewIndicator(3);
    slideView = new SlideView(3, indicator);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('首页', style: new TextStyle(fontSize: 18.0),),
        elevation: 0.0,
      ),
      drawer: new Drawer(
        child: new MyDrawer(
          name: '无忌0713',
          email: '492874653@qq.com',
          profileimg: "images/profile_3.jpg",
          background: "images/bg_2.jpg",
        ) 
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            height: 180.0,
            child: new Stack(
              children: <Widget>[
                slideView,
                new Container(
                  alignment: Alignment.bottomCenter,
                  child: indicator,
                )              ],
            ),
          ),
          new Expanded(
              child: new NewsList(media: '',),
          ),
        ],
      ),
    );
  }
}