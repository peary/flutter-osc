import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './constants/Constants.dart';
import './events/ChangeThemeEvent.dart';
import './util/DataUtils.dart';
import './util/ThemeUtils.dart';
import './pages/NewsTabPage.dart';


void main() {
  runApp(new App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AppState();
}

class AppState extends State<App> {

  Color themeColor = ThemeUtils.defaultColor;

  @override
  void initState() {
    super.initState();

    DataUtils.getColorThemeIndex().then((index) {
      print('color theme index = $index');
      if (index != null) {
        ThemeUtils.currentColor = ThemeUtils.supportColors[index];
        Constants.eventBus.fire(new ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    Constants.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: themeColor
      ),
      
      home: new Scaffold(
        body: new NewsTabPage(),
      ),
    );
  }
}

