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

  _initPopupActions() {
    return new PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
          value: "likeUrl", 
          // child: new Text('收藏链接', style: TextStyle(fontSize: 16),)
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: (){},
                )
            ),
            Text('收藏链接')
          ])
        ),
        new PopupMenuItem<String>(
          value: "copyUrl", 
          // child: new Text('复制链接', style: TextStyle(fontSize: 16),)
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed: (){},
                )
            ),
            Text('复制链接')
          ])
        ),
        new PopupMenuItem<String>(
          value: "openUrl", 
          // child: new Text('用浏览器打开', style: TextStyle(fontSize: 16),)
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: IconButton(
                  icon: Icon(Icons.open_in_browser),
                  onPressed: (){
                    _launchURL(this.url);
                  },
                )),
            Text('用浏览器打开')
          ])
        ),
        new PopupMenuItem<String>(
          value: "shareTo", 
          child: Row(children: <Widget>[
            Padding( padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: (){
                    Share.share(this.title + ' [' + this.url + '][分享自PaperPlane]');
                  },
                ),
              ),
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

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
          _initPopupActions(),
        ],
        // actions: <Widget>[
        //   new IconButton(
        //     icon: Icon(Icons.share),
        //     onPressed: (){
        //       Share.share(this.title + ' [' + this.url + '][分享自PaperPlane]');
        //     },
        //   )
        // ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withLocalUrl: true,
      withJavascript: true,
      allowFileURLs: true,
    );
  }
}
