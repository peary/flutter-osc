import 'package:flutter/material.dart';
import 'dart:async';
import 'OfflineActivityPage.dart';
import 'CommonWebPage.dart';
import 'package:barcode_scan/barcode_scan.dart';

class DiscoveryPage extends StatelessWidget {

  static const String TAG_START = "startDivider";
  static const String TAG_END = "endDivider";
  static const String TAG_CENTER = "centerDivider";
  static const String TAG_BLANK = "blankDivider";

  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  final imagePaths = [
    "images/ic_discover_softwares.png",
    "images/ic_discover_git.png",
    "images/ic_discover_gist.png",
    "images/ic_discover_scan.png",
    "images/ic_discover_shake.png",
    "images/ic_discover_nearby.png",
    "images/ic_discover_pos.png",
  ];
  final titles = [
    "开源软件", "码云推荐", "代码片段", "扫一扫", "摇一摇", "码云封面人物", "线下活动"
  ];
  final rightArrowIcon = new Image.asset('images/ic_arrow_right.png', width: ARROW_ICON_WIDTH, height: ARROW_ICON_WIDTH,);
  final titleTextStyle = new TextStyle(fontSize: 18.0);
  List listData = [];

  DiscoveryPage() {
    initData();
  }

  initData() {
    listData.add(TAG_START);
    for (int i = 0; i < 3; i++) {
      listData.add(new ListItem(title: titles[i], icon: imagePaths[i]));
      if (i == 2) {
        listData.add(TAG_END);
      } else {
        listData.add(TAG_CENTER);
      }
    }
    listData.add(TAG_BLANK);
    listData.add(TAG_START);
    for (int i = 3; i < 5; i++) {
      listData.add(new ListItem(title: titles[i], icon: imagePaths[i]));
      if (i == 4) {
        listData.add(TAG_END);
      } else {
        listData.add(TAG_CENTER);
      }
    }
    listData.add(TAG_BLANK);
    listData.add(TAG_START);
    for (int i = 5; i < 7; i++) {
      listData.add(new ListItem(title: titles[i], icon: imagePaths[i]));
      if (i == 6) {
        listData.add(TAG_END);
      } else {
        listData.add(TAG_CENTER);
      }
    }
  }

  Widget getIconImage(path) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: new Image.asset(path, width: IMAGE_ICON_WIDTH, height: IMAGE_ICON_WIDTH),
    );
  }

  renderRow(BuildContext ctx, int i) {
    var item = listData[i];
    if (item is String) {
      switch (item) {
        case TAG_START:
          return new Divider(height: 1.0,);
          break;
        case TAG_END:
          return new Divider(height: 1.0,);
          break;
        case TAG_CENTER:
          return new Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
            child: new Divider(height: 1.0,),
          );
          break;
        case TAG_BLANK:
          return new Container(
            height: 20.0,
          );
          break;
      }
    } else if (item is ListItem) {
      var listItemContent =  new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: new Row(
          children: <Widget>[
            getIconImage(item.icon),
            new Expanded(
                child: new Text(item.title, style: titleTextStyle,)
            ),
            rightArrowIcon
          ],
        ),
      );
      return new InkWell(
        onTap: () {
          handleListItemClick(ctx, item);
        },
        child: listItemContent,
      );
    }
  }

  void handleListItemClick(BuildContext ctx, ListItem item) {
    String title = item.title;
    if (title == "扫一扫") {
      scan();
    } else if (title == "线下活动") {
      Navigator.of(ctx).push(new MaterialPageRoute(
        builder: (context) {
          return new OfflineActivityPage();
        }
      ));
    } else if (title == "码云推荐") {
      Navigator.of(ctx).push(new MaterialPageRoute(
          builder: (context) {
            return new CommonWebPage(title: "码云推荐", url: "https://m.gitee.com/explore");
          }
      ));
    } else if (title == "代码片段") {
      Navigator.of(ctx).push(new MaterialPageRoute(
          builder: (context) {
            return new CommonWebPage(title: "代码片段", url: "https://m.gitee.com/gists");
          }
      ));
    } else if (title == "开源软件") {
      Navigator.of(ctx).push(new MaterialPageRoute(
          builder: (context) {
            return new CommonWebPage(title: "开源软件", url: "https://m.gitee.com/explore");
          }
      ));
    } else if (title == "码云封面人物") {
      Navigator.of(ctx).push(new MaterialPageRoute(
          builder: (context) {
            return new CommonWebPage(title: "码云封面人物", url: "https://m.gitee.com/gitee-stars/");
          }
      ));
    }
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('热点', style: new TextStyle(fontSize: 16.0),),
        elevation: 0.0,
      ),
      body: new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: new ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, i) => renderRow(context, i),
        ),
      )
    );
  }

}

class ListItem {
  String icon;
  String title;
  ListItem({this.icon, this.title});
}