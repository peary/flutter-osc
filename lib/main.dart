import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc/constants/Constants.dart';
import 'package:flutter_osc/events/ChangeThemeEvent.dart';
import 'package:flutter_osc/util/DataUtils.dart';
import 'package:flutter_osc/util/ThemeUtils.dart';
import 'pages/NewsListPage.dart';
import 'pages/TweetsListPage.dart';
import 'pages/DiscoveryPage.dart';
// import 'pages/HotPage.dart';
import 'pages/MyInfoPage.dart';
import './widgets/MyDrawer.dart';

void main() {
  runApp(new MyOSCClient());
}

class MyOSCClient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyOSCClientState();
}

class MyOSCClientState extends State<MyOSCClient> {
  final appBarTitles = ['首页', '推荐', '热点', '我的'];
  final appBarIcons = [
    Icon(Icons.home),
    Icon(Icons.tune),
    Icon(Icons.whatshot),
    Icon(Icons.person)
  ];

  Color themeColor = ThemeUtils.currentColorTheme;

  final tabTextStyleSelected = new TextStyle(color: ThemeUtils.currentColorTheme);
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));

  int _tabIndex = 0;

  var _body;
  var pages;

  PageController pageController;

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this._tabIndex);

    DataUtils.getColorThemeIndex().then((index) {
      print('color theme index = $index');
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        Constants.eventBus.fire(new ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    Constants.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
    pages = <Widget>[
      // new NewsListPage(),
      // new TweetsListPage(),
      // new NewsListPage(),
      // new MyInfoPage(),

      new NewsListPage(),
      new NewsListPage(),
      new NewsListPage(),
      new NewsListPage()
    ];
    
    _body = new IndexedStack(
      children: pages,
      index: _tabIndex,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Icon getTabIcon(int curIndex) {
    return appBarIcons[curIndex];
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex]);
    // return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  @override
  Widget build(BuildContext context) {
    _body = new IndexedStack(
      children: pages,
      index: _tabIndex,
    );
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: themeColor
      ),
      
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(appBarTitles[_tabIndex],),
        ),
        drawer: new Drawer(
          child: new MyDrawer(
            email: '492874653@qq.com',
            name: '无忌0713',
            profileimg: "images/profile_3.jpg",
            background: "images/bg_2.jpg",
          ) 
        ),
        body: _body,
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0),
                title: getTabTitle(0),
                backgroundColor: ThemeUtils.defaultColor),
            new BottomNavigationBarItem(
                icon: getTabIcon(1),
                title: getTabTitle(1),
                backgroundColor: ThemeUtils.defaultColor),
            new BottomNavigationBarItem(
                icon: getTabIcon(2),
                title: getTabTitle(2),
                backgroundColor: ThemeUtils.defaultColor),
            new BottomNavigationBarItem(
                icon: getTabIcon(3),
                title: getTabTitle(3),
                backgroundColor: ThemeUtils.defaultColor)
          ],
          currentIndex: _tabIndex,
          fixedColor: ThemeUtils.currentColorTheme,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState((){
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}

