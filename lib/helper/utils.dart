import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';

class Utils {}

class ScreenInfo {
  late double width;
  late double height;

  ScreenInfo(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}

class DateHelper {
  static String countDate(DateTime date) {
    return DateTimeFormat.relative(date, levelOfPrecision: 3, abbr: true);
  }
}
