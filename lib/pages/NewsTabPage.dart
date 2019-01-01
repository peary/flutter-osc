import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/ThemeUtils.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import '../constants/Constants.dart';
import '../pages/NewsDetailPage.dart';
import '../widgets/CommonEndLine.dart';
import '../widgets/NewsListView.dart';


class NewsTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewsTabPageState();
}

class NewsTabPageState extends State<NewsTabPage>
  with SingleTickerProviderStateMixin {
  
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(vsync: this, length: _allPages.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('分类'),
        elevation: 0.0,
        bottom: new TabBar(
          controller: _controller,
          indicatorColor: ThemeUtils.currentColor,
          isScrollable: true,
          tabs: _allPages.map((_Page page) {
            return
              new Tab(text: page.text);
          }).toList(),
        ),
      ),

      body: new TabBarView(controller: _controller,
          children: _allPages.map((_Page page) {
            return page.newsList;
          }).toList()),
    );
  }
}

class _Page {
  _Page({
    this.icon,
    this.text,
    this.newsList
  });

  final IconData icon;
  final String text;
  final NewsList newsList;
}
// 存储所有页面的列表
final List<_Page> _allPages = <_Page>[
  new _Page(text: "全部",
      newsList: new NewsList(tagID:(''))),
  new _Page(text: "机器之心",
      newsList: new NewsList(tagID:('732'))),
  new _Page(text: "量子位",
      newsList: new NewsList(tagID:('609'))),
  new _Page(text: "微信",
      newsList: new NewsList(tagID:('111'))),
  new _Page(text: "CSDN",
      newsList: new NewsList(tagID:('42'))),
  new _Page(text: "36氪",
      newsList: new NewsList(tagID:('709'))),
  new _Page(text: "药品",
      newsList: new NewsList(tagID:('303'))),
  new _Page(text: "Python",
      newsList: new NewsList(tagID:('91'))),
];


