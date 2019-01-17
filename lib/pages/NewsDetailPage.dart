import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  final _flutterWebView = new FlutterWebviewPlugin();
  // URL变化监听器
  StreamSubscription<String> _onUrlChanged;
  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> _onStateChanged;


  NewsDetailPageState({Key key, this.url, this.title});

  @override
  void initState() {
    super.initState();

    _flutterWebView.close();

    // 监听WebView的加载事件
    _flutterWebView.onDestroy.listen((_) {
      print("destroy");
    });

    _onUrlChanged = _flutterWebView.onUrlChanged.listen((String url) {
      print("URL changed: " + this.url + " -> $url");
    });

    _onStateChanged = _flutterWebView.onStateChanged.listen((state) {
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
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _flutterWebView.dispose();
    super.dispose();
  }

  _initPopupMenu() {
    return new PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
          value: "likeURL", 
          child: new ListTile(
            title: new Text("收藏链接"),
            trailing: new Icon(Icons.star_border,),
            onTap: () {
              Fluttertoast.showToast(msg: '收藏成功!');
            },
          ),
        ),
        new PopupMenuItem<String>(
          value: "copyURL", 
          child: new ListTile(
            title: new Text("复制链接"),
            trailing: new Icon(Icons.content_copy,),
            onTap: () {
              _copy(this.url);
            },
          ),
        ),
        new PopupMenuItem<String>(
          value: "openURL", 
          child: new ListTile(
            title: new Text("用浏览器打开"),
            trailing: new Icon(Icons.open_in_browser,),
            onTap: () {
              _launchURL(this.url);
            },
          ),
        ),
        new PopupMenuItem<String>(
          value: "shareURL", 
          child: new ListTile(
            title: new Text("分享到"),
            trailing: new Icon(Icons.share,),
            onTap: () {
              Share.share(this.title + ' [' + this.url + '][分享自PaperPlane]');
            },
          ),
        ),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: '链接打开失败!');
    }
  }
  
  _copy(String content) {
    Clipboard.setData(new ClipboardData(text: content));
    Fluttertoast.showToast(msg: '链接已复制到剪切板!');
  }
  
  _renderTitle() {
    if (url == null || url.length == 0) {
      return new Text(title);
    }

    String showTitle = title.length > 14 ? title.substring(0,15) + '...' : title;

    List<Widget> titleContent = [
      new Text(showTitle, textAlign: TextAlign.left, style: TextStyle(fontSize: 16),),
    ];

    if (!loaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }

    return new Row(
      children: titleContent
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return new WebviewScaffold(
      appBar: new AppBar(
        title: _renderTitle(),
        actions: <Widget>[
          _initPopupMenu(),
        ],
      ),
      url: this.url,
      scrollBar: true,
      withLocalUrl: true,
      withJavascript: true,
    );
  }
}
