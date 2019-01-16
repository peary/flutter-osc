import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';


class CommonOptionWidget extends StatelessWidget {
  final List<OptionModel> otherList;

  final OptionControl control;

  CommonOptionWidget(this.control, {this.otherList});

  _renderHeaderPopItem(List<OptionModel> list) {
    return new PopupMenuButton<OptionModel>(
      child: new Icon(Icons.more_horiz),
      onSelected: (model) {
        model.selected(model);
      },
      itemBuilder: (BuildContext context) {
        return _renderHeaderPopItemChild(list);
      },
    );
  }

  _renderHeaderPopItemChild(List<OptionModel> data) {
    List<PopupMenuEntry<OptionModel>> list = new List();
    for (OptionModel item in data) {
      list.add(PopupMenuItem<OptionModel>(
        value: item,
        child: new Text(item.name),
      ));
    }
    return list;
  }

  static _launchOutURL(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: '打开失败: ' + url);
    }
  }
  
  static _copy(String data, BuildContext context) {
    Clipboard.setData(new ClipboardData(text: data));
    Fluttertoast.showToast(msg: '复制成功!');
  }

  @override
  Widget build(BuildContext context) {
    List<OptionModel> list = [
      new OptionModel('加入收藏', 'likeURL', (model) {
      }),
      new OptionModel('分享', 'shareURL', (model) {
        Share.share(control.title + ' [' + control.url + '][分享自PaperPlane]');
      }),
      new OptionModel('用浏览器打开', 'openURL', (model) {
        _launchOutURL(control.url, context);
      }),
      new OptionModel('复制链接', 'copyURL', (model) {
        _copy(control.url ?? "", context);
      }),
    ];
    if (otherList != null && otherList.length > 0) {
      list.addAll(otherList);
    }
    return _renderHeaderPopItem(list);
  }
}

class OptionControl {
  String url = 'https://blockshare.top';
  String title = '';
}

class OptionModel {
  final String name;
  final String value;
  final PopupMenuItemSelected<OptionModel> selected;

  OptionModel(this.name, this.value, this.selected);
}
