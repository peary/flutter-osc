import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xpath/xpath.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import 'CommonWebPage.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HotPageState();
  }
}

class HotPageState extends State<HotPage> {
  var hotTopics;

  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  final rightArrowIcon = new Image.asset('images/ic_arrow_right.png', width: ARROW_ICON_WIDTH, height: ARROW_ICON_WIDTH,);
  final titleTextStyle = new TextStyle(fontSize: 16.0);

  @override
  void initState() {
    super.initState();
    getHotTopics();
  }

  List<String> getHotTopics() {
    String url = Api.WEIBO_HOT_TOPICS;
    NetUtils.get(url).then((data) {
      if (data != null) {
        String html = data.toString();
      }
    }
  }

  renderRow(BuildContext ctx, int i) {
    var item = hotTopics[i];
    
    var listItemContent =  new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: new Row(
        children: <Widget>[
          item['rank'],
          new Expanded(
              child: new Text(item['topic'], style: titleTextStyle,)
          ),
          item['hotDegree'],
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


  void handleListItemClick(BuildContext ctx, Map<String, String> item) {
    Navigator.of(ctx).push(
      new MaterialPageRoute(
          builder: (context) {
            return new CommonWebPage(title: item['topic'], url: item['gotoUrl']);
          }
      ));
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new ListView.builder(
        itemCount: hotTopics.length,
        itemBuilder: (context, i) => renderRow(context, i),
      ),
    );
  }
}


class ListItem {
  String rank;
  String topic;
  String gotoUrl;
  String hotDegree;
}