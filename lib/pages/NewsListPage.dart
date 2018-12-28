import 'dart:async';
import 'package:flutter/material.dart';
import '../util/NetUtils.dart';
import '../api/Api.dart';
import 'dart:convert';
import '../constants/Constants.dart';
import '../pages/NewsDetailPage.dart';
import '../widgets/CommonEndLine.dart';
import '../widgets/SlideView.dart';
import '../widgets/SlideViewIndicator.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  final ScrollController _controller = new ScrollController();
  final TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  final TextStyle subtitleStyle = new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);

  var listData;
  var slideData;
  var curPage = 1;
  var listTotalSize = 0;

  SlideView slideView;
  SlideViewIndicator indicator;

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
    int page_size = 10;
    url += "?page=$curPage&per_page=$page_size";
    print(url);
    NetUtils.get(url).then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        List result = json.decode(data);
        
        if (result.length > 0) {
          // code=0表示请求成功
          // total表示资讯总条数
          listTotalSize = 500;
          // data为数据内容，其中包含slide和news两部分，分别表示头部轮播图数据，和下面的列表数据
          var _slideData = result.sublist(0, 3);
          var _listData = result.sublist(3, page_size);
          setState(() {
            if (!isLoadMore) {
              // 不是加载更多，则直接为变量赋值
              listData = _listData;
              slideData = _slideData;
            } else {
              // 是加载更多，则需要将取到的news数据追加到原来的数据后面
              List newData = new List();
              // 添加原来的数据
              newData.addAll(listData);
              // 添加新取到的数据
              newData.addAll(_listData);
              // 判断是否获取了所有的数据，如果是，则需要显示底部的"我也是有底线的"布局
              if (newData.length >= listTotalSize) {
                newData.add(Constants.END_LINE_TAG);
              }
              // 给列表数据赋值
              listData = newData;
              // 轮播图数据
              slideData = _slideData;
            }
            initSlider();
          });
        }
      }
    });
  }

  void initSlider() {
    indicator = new SlideViewIndicator(slideData.length);
    slideView = new SlideView(slideData, indicator);
  }

  Widget renderRow(i) {
    if (i == 0) {
      return new Container(
        height: 180.0,
        child: new Stack(
          children: <Widget>[
            slideView,
            new Container(
              alignment: Alignment.bottomCenter,
              child: indicator,
            )
          ],
        ),
      );
    }
    i -= 1;
    if (i.isOdd) {
      return new Divider(height: 1.0);
    }
    i = i ~/ 2;
    var itemData = listData[i];
    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new CommonEndLine();
    }
    var titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(itemData['title']['rendered'], style: titleTextStyle),
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
                image: new NetworkImage(itemData['post_medium_image']), fit: BoxFit.cover),
            border: new Border.all(
              color: const Color(0xFFECECEC),
              width: 2.0,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            itemData['date'],
            style: subtitleStyle,
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text("${itemData['pageviews']}", style: subtitleStyle),
              new Image.asset('./images/ic_comment.png', width: 16.0, height: 16.0),
            ],
          ),
        )
      ],
    );
    var thumbImgUrl = itemData['post_thumbnail_image'];
    var thumbImg = new Container();
    // var thumbImg = new Container(
    //   margin: const EdgeInsets.all(10.0),
    //   width: 60.0,
    //   height: 60.0,
    //   decoration: new BoxDecoration(
    //     shape: BoxShape.circle,
    //     color: const Color(0xFFECECEC),
    //     image: new DecorationImage(
    //         image: new ExactAssetImage('./images/ic_img_default.jpg'),
    //         fit: BoxFit.cover),
    //     border: new Border.all(
    //       color: const Color(0xFFECECEC),
    //       width: 2.0,
    //     ),
    //   ),
    // );
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      thumbImg = new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(thumbImgUrl), 
              fit: BoxFit.cover
          ),
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0,
          )
        ),
      );
    }
    var row = new Row(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                titleRow,
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: timeRow,
                )
              ],
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Container(
            width: 100.0,
            height: 80.0,
            color: const Color(0xFFECECEC),
            child: new Center(
              child: thumbImg,
            ),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(5)
            )
          ),
        )
      ],
    );
    return new InkWell(
      child: row,
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (ctx) => new NewsDetailPage(id: itemData['link'])
        ));
      },
    );
  }
}
