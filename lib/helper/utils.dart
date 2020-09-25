import 'package:flutter/cupertino.dart';

class Utils {}

class ScreenInfo {
  double width;
  double height;

  ScreenInfo(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}
