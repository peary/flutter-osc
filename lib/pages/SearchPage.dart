import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  void changeContent() {
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    changeContent();
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: (content) {
        changeContent();
      },
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: '搜索真的好了，不骗你',
        hintStyle: TextStyle(color: Colors.white24),
      ),
      controller: controller,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                changeContent();
              }),
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                setState(() {
                  controller.clear();
                });
              }),
        ],
      ),
      body: new Text('doing'),
    );
  }
}
