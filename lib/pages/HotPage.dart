import 'dart:convert';
import 'package:flutter/material.dart';
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
  List hotTopics = new List();

  final ScrollController _controller = new ScrollController();

  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  final rightArrowIcon = new Image.asset('images/ic_arrow_right.png', width: ARROW_ICON_WIDTH, height: ARROW_ICON_WIDTH,);
  final titleTextStyle = new TextStyle(fontSize: 16.0);

  @override
  void initState() {
    super.initState();
    getHotTopics();
  }

  getHotTopics() {
    String url = Api.WEIBO_HOT_TOPICS;
    NetUtils.get(url).then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);
        if (map['ok'] == 1) {
          // hotTopics.addAll(map['data']['cards'][0]['card_group']);
          var cards = map['data']['cards'];
          if (cards != null && cards.length > 0) {
            var items = cards[0]['card_group'];
            for (var i=0; i<items.length; i++) {
              var item = items[i];
              TopicItem topic = new TopicItem();
              topic.topic = item['desc'];
              topic.gotoUrl = item['scheme'];
              topic.hotDegree = item['desc_extr'];
              topic.rank = (i + 1).toString();
              hotTopics.add(topic);
            }
            print(hotTopics.length);
          }
        }
      }
    });
  }

  Future<Null> _pullToRefresh() async {
    getHotTopics();
    return null;
  }

  Widget renderRow(int i) {
    TopicItem topic = hotTopics[i];
    
    var listItem =  new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: new Row(
        children: <Widget>[
          new Text(topic.rank, style: titleTextStyle),
          new Expanded(
              child: new Text(topic.topic, style: titleTextStyle,)
          ),
          new Text(topic.hotDegree, style: titleTextStyle)
        ],
      ),
    );
    return new InkWell(
      onTap: () {
        return new CommonWebPage(title: topic.topic, url: topic.gotoUrl);
      },
      child: listItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 无数据时，显示Loading
    if (hotTopics == null) {
      return new Center(
        // CircularProgressIndicator是一个圆形的Loading进度条
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: hotTopics.length,
        itemBuilder: (context, i) => renderRow(i),
        controller: _controller,
      );
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }
}


class TopicItem {
  String rank;
  String topic;
  String gotoUrl;
  String hotDegree;
  String icon;
}