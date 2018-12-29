import 'package:flutter/material.dart';
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
          title: new Text("更换主题"),
          trailing: new Icon(
            Icons.color_lens,
          ),
          onTap: () {
            print("Theme Color");
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new ChangeThemePage();
            }));
          },
        ),new ListTile(
          title: new Text("搜索"),
          trailing: new Icon(
            Icons.search,
          ),
          onTap: () {
            print("Theme Color");
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new ChangeThemePage();
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
          title: new Text("联系我们"),
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
