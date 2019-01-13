import 'package:flutter/material.dart';
import '../pages/HotPage.dart';
import '../pages/SearchPage.dart';
import '../pages/AboutPage.dart';
import '../pages/ChangeThemePage.dart';


class MyDrawer extends StatelessWidget {
  String email, name, profileimg, background;

  MyDrawer({this.background, this.profileimg, this.name, this.email});

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text(name),
          accountEmail: new Text(email),
          currentAccountPicture:
              new CircleAvatar(backgroundImage: new AssetImage(profileimg)),
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage(background), fit: BoxFit.cover)),
        ),
        new ListTile(
          title: new Text("我的订阅"),
          trailing: new Icon(Icons.whatshot,),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new SearchPage();
            }));
          },
        ),
        new ListTile(
          title: new Text("更换主题"),
          trailing: new Icon(Icons.color_lens,),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new ChangeThemePage();
            }));
          },
        ),
        new ListTile(
          title: new Text("热点话题"),
          trailing: new Icon(Icons.whatshot,),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new HotPage();
            }));
          },
        ),
        new ListTile(
          title: new Text("退出登录"),
          trailing: new Icon(Icons.exit_to_app),
          onTap: () {
            print("Exit");
            Navigator.of(context).pop();
          },
        ),
        new ListTile(
          title: new Text("关于我们"),
          trailing: new Icon(Icons.question_answer),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new AboutPage();
            }));
          },
        ),
      ],
    );
  }
}
