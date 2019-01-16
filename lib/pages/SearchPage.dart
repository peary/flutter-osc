import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/NewsListView.dart';

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
        hintText: '搜索...',
        hintStyle: TextStyle(color: Colors.white),
      ),
      controller: controller,
    );

    var body;
    if (controller.text == null || controller.text == '') {
      body = new Center(
        child: Text('请输入关键词', style: TextStyle(fontSize: 16),),
      );
    } else {
      body = new NewsList(search: controller.text);
    }

    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              changeContent();
            }
          ),
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () {
              setState(() {
                controller.clear();
              });
            }
          ),
        ],
      ),
      body: body,
    );
  }
}
