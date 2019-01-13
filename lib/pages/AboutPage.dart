import 'package:flutter/material.dart';
import 'CommonWebPage.dart';

// "关于"页面

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AboutPageState();
  }
}

class AboutPageState extends State<AboutPage> {
  bool showImage = false;
  TextStyle textStyle = new TextStyle(
      color: Colors.blue,
      decoration: new TextDecoration.combine([TextDecoration.underline]));
  Widget authorLink, mayunLink, githubLink;
  List<String> urls = new List();
  List<String> titles = new List();

  AboutPageState() {
    titles.add("yubo's blog");
    titles.add("码云");
    titles.add("GitHub");
    urls.add("https://yubo725.top");
    urls.add("https://gitee.com/yubo725");
    urls.add("https://github.com/yubo725");
    authorLink = new GestureDetector(
      child: new Container(
        margin: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("作者："),
            new Text(
              "yubo",
              style: textStyle,
            ),
          ],
        ),
      ),
      onTap: getLink(0),
    );
    mayunLink = new GestureDetector(
      child: new Container(
        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("码云："),
            new Text(
              "https://gitee.com/yubo725",
              style: textStyle,
            )
          ],
        ),
      ),
      onTap: getLink(1),
    );
    githubLink = new GestureDetector(
      child: new Container(
        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("GitHub："),
            new Text(
              "https://github.com/yubo725",
              style: textStyle,
            ),
          ],
        ),
      ),
      onTap: getLink(2),
    );
  }

  getLink(index) {
    String url = urls[index];
    String title = titles[index];
    return () {
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return new CommonWebPage(title: title, url: url);
      }));
    };
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("关于", style: new TextStyle(fontSize: 16.0),),
        elevation: 0.0,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Container(
              width: 1.0,
              height: 100.0,
              color: Colors.transparent,
            ),
            new Text("享受阅读，相信个体的力量！", style: new TextStyle(fontSize: 16),),
            new Container(
                margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: new Text(
                  "本项目基于Google Flutter 1.0开发",
                  style: new TextStyle(fontSize: 12.0),
                ))
          ],
        ),
      ));
  }
}
