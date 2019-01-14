import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class NewsDetailPage extends StatefulWidget {

  String url;
  String title;

  NewsDetailPage({Key key, this.url, this.title}):super(key: key);

  @override
  State<StatefulWidget> createState() => new NewsDetailPageState(url: this.url, title: this.title);
}

class NewsDetailPageState extends State<NewsDetailPage> {

  String url;
  String title;
  bool loaded = false;
  String detailDataStr;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  NewsDetailPageState({Key key, this.url, this.title});

  @override
  void initState() {
    super.initState();
    // 监听WebView的加载事件
    flutterWebViewPlugin.onStateChanged.listen((state) {
      print("state: ${state.type}");
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          loaded = true;
        });
      }
    });
  }

  Widget PopupAction() {
    return new PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
          value: "likeUrl", 
          // child: new Text('收藏链接', style: TextStyle(fontSize: 16),)
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Icon(Icons.star_border)),
            Text('收藏链接')
          ])
        ),
        new PopupMenuItem<String>(
          value: "copyUrl", 
          // child: new Text('复制链接', style: TextStyle(fontSize: 16),)
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Icon(Icons.content_copy)),
            Text('复制链接')
          ])
        ),
        new PopupMenuItem<String>(
          value: "openUrl", 
          // child: new Text('用浏览器打开', style: TextStyle(fontSize: 16),)
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Icon(Icons.open_in_browser)),
            Text('用浏览器打开')
          ])
        ),
        new PopupMenuItem<String>(
          value: "shareTo", 
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Icon(Icons.share)),
            Text('分享到')
          ])
        ),
      ],
      onSelected: (String value) {
        switch (value) {
          case "likeUrl":
          // do nothing
            break;
          case "copyUrl":
          // do nothing
            break;
          case "openUrl":
          // do nothing
            break;
          case "shareTo":
          // do nothing
            break;
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    List<Widget> actions = [];

    titleContent.add(
      new Text(title, textAlign: TextAlign.left, style: TextStyle(fontSize: 16),)
    );
    if (!loaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0));
    
    actions = <Widget>[
      PopupAction(),
    ];

    return new WebviewScaffold(
      url: this.url,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: titleContent,
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              Share.share('分享自PaperPlane: ' + this.url);
            },
          )
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withLocalUrl: true,
      withJavascript: true,
      allowFileURLs: true,
    );
  }
}