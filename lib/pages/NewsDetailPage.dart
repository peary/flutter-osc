import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(
      new Text(title, textAlign: TextAlign.left, style: TextStyle(fontSize: 16),)
    );
    if (!loaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0));
    return new WebviewScaffold(
      url: this.url,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: titleContent,
        ),
        actions: <Widget>[
          new Padding(
            padding: EdgeInsets.all(0),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
              },
            ) 
          ),
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
      allowFileURLs: true,
    );
  }
}