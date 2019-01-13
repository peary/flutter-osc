import 'package:flutter/material.dart';

class ThemeUtils {
  // 默认主题色
  // static const Color defaultColor = const Color();
  // static const Color defaultColor = const Color(0xFF63FDD9);
  
  // static const Color defaultColor = Colors.white10

  static const blackColor = Color(0xFF363636);
  static const whiteColor = Color(0xFFE0E0E0);

  static const defaultColor = blackColor;

  // 可选的主题色
  static const List<Color> supportColors = [
    blackColor,
    Colors.black,
    Colors.purple, 
    Colors.orange,
    Colors.deepOrange, 
    Colors.deepPurpleAccent, 
    Colors.red, 
    Colors.blue, 
    Colors.amber, 
    Colors.green, 
    Colors.lime, 
    Colors.indigo, 
    Colors.cyan, 
    Colors.teal,
    Colors.pink,
    whiteColor,
  ];

  // 当前的主题色
  static Color currentColor = defaultColor;
}