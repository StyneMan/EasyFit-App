import 'package:flutter/material.dart';

class DrawerModel {
  String icon;
  String title;
  Widget? widget;
  bool isAction;

  DrawerModel({
    required this.icon,
    required this.title,
    this.widget,
    required this.isAction,
  });
}
