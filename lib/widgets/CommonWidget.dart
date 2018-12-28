import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//HTTP请求的函数返回值为异步控件Future
Future<String> get(String url) async {
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  return await response.transform(utf8.decoder).join();
}

///异常处理
Widget buildExceptionIndicator(String message) {
  return new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Align(
        alignment: Alignment.center,
        child: new Column(
          children: <Widget>[
            new Image.asset(
              'images/empty_data.png',
              width: 50.0,
              height: 50.0,
              color: Colors.grey,
            ),
            new Container(
              padding: EdgeInsets.only(top: 20.0),
              child: new Text(
                message,
                style: const TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    ],
  );
}

///正在加载
Widget buildLoadingIndicator() {
  return new Center(
    child: new CupertinoActivityIndicator(),
  );
}
