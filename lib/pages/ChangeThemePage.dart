import 'package:flutter/material.dart';
import '../constants/Constants.dart';
import '../events/ChangeThemeEvent.dart';
import '../util/DataUtils.dart';
import '../util/ThemeUtils.dart';

class ChangeThemePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangeThemePageState();
}

class ChangeThemePageState extends State<ChangeThemePage> {

  List<Color> colors = ThemeUtils.supportColors;

  changeColorTheme(Color c) {
    Constants.eventBus.fire(new ChangeThemeEvent(c));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('切换主题', style: TextStyle(fontSize: 16),),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(4.0),
        child: new GridView.count(
          crossAxisCount: 4,
          children: new List.generate(colors.length, (index) {
            return new InkWell(
              onTap: () {
                ThemeUtils.currentColor = colors[index];
                DataUtils.setColorTheme(index);
                changeColorTheme(colors[index]);
              },
              child: new Container(
                color: colors[index],
                margin: const EdgeInsets.all(3.0),
              ),
            );
          }),
        )
      )
    );
  }

}