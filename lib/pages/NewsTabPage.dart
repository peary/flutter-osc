import 'package:flutter/material.dart';
import '../util/ThemeUtils.dart';
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
    super.initState();
    _controller = new TabController(
      initialIndex: 0,
      vsync: this, 
      length: _allPages.length
    );
  }

  @override
  void dispose() {
    if(_controller != null){
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text('分类', style: new TextStyle(fontSize: 18.0),),
        elevation: 0.0,
        bottom: new TabBar(
          controller: _controller,
          indicatorColor: ThemeUtils.currentColor,
          // indicatorPadding: EdgeInsets.all(1.0),
          isScrollable: true,
          tabs: _allPages.map((_Page page) {
            return
              new Tab(text: page.text);
          }).toList(),
        ),
        actions: <Widget>[
          new Padding(padding: const EdgeInsets.all(2.0),
            child: new IconButton(
              icon: new Icon(Icons.reorder),
              onPressed: () {
              },),
          ),
          new Padding(padding: const EdgeInsets.all(2.0),
            child: new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
              },),),
        ],
      ),

      body: new TabBarView(
        controller: _controller,
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
  // new _Page(text: "全部",
  //     newsList: new NewsList(media:(''))),
  new _Page(text: "科技资讯",
      newsList: new NewsList(media:('36氪,钛媒体APP,cnBeta,i黑马,差评,爱否科技,爱范儿,躺倒鸭,造就'))),
  new _Page(text: "机器学习",
      newsList: new NewsList(media:('机器之心,量子位,坤艮机器之心,新智元'))),
  new _Page(text: "金融财经",
      newsList: new NewsList(media:('一本财经,华尔街见闻,每日经济新闻,泽平宏观'))),
  new _Page(text: "医疗教育",
      newsList: new NewsList(media:('动脉网,芥末堆看教育'))),
  new _Page(text: "新闻媒体",
      newsList: new NewsList(media:('南方周末,正和岛,经济观察报'))),
  new _Page(text: "初创动态",
      newsList: new NewsList(media:('铅笔道'))),
];


