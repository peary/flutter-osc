import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './ThemeUtils.dart';

class IndicatorFactory {
  Widget buildDefaultHeader(BuildContext context, int mode) {
    return new ClassicIndicator(
      failedText: '刷新失败!',
      completeText: '刷新完成!',
      releaseText: '释放可以刷新',
      idleText: '下拉刷新哦!',
      failedIcon: new Icon(Icons.clear, color: ThemeUtils.currentColorTheme),
      completeIcon:
          new Icon(Icons.forward_30, color: ThemeUtils.currentColorTheme),
      idleIcon:
          new Icon(Icons.arrow_downward, color: ThemeUtils.currentColorTheme),
      releaseIcon:
          new Icon(Icons.arrow_upward, color: ThemeUtils.currentColorTheme),
      refreshingText: '正在刷新...',
      textStyle: new TextStyle(inherit: true, color: ThemeUtils.currentColorTheme),
      mode: mode,
      refreshingIcon: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation(Colors.red),
      ),
    );
  }

  Widget buildDefaultFooter(BuildContext context, int mode,
      [Function requestLoad]) {
    if (mode == RefreshStatus.failed || mode == RefreshStatus.idle) {
      return new InkWell(
        child: new ClassicIndicator(
          mode: mode,
          idleIcon:
              new Icon(Icons.arrow_upward, color: ThemeUtils.currentColorTheme),
          textStyle:
              new TextStyle(inherit: true, color: ThemeUtils.currentColorTheme),
          releaseIcon:
              new Icon(Icons.arrow_upward, color: ThemeUtils.currentColorTheme),
          refreshingText: '火热加载中...',
          idleText: '上拉加载',
          failedText: '网络异常',
          releaseText: '释放可以加载',
          noDataText: '没有更多数据',
          refreshingIcon: const CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
        ),
        onTap: requestLoad,
      );
    } else
      return new ClassicIndicator(
          mode: mode,
          idleIcon:
              new Icon(Icons.arrow_upward, color: ThemeUtils.currentColorTheme),
          textStyle:
              new TextStyle(inherit: true, color: ThemeUtils.currentColorTheme),
          releaseIcon:
              new Icon(Icons.arrow_upward, color: ThemeUtils.currentColorTheme),
          refreshingText: '火热加载中...',
          idleText: '上拉加载',
          failedText: '网络异常',
          releaseText: '释放可以加载',
          refreshingIcon: const CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
          noDataText: '没有更多数据');
  }
}
