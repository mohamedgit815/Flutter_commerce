import 'package:flutter/material.dart';

class AppColor {

  /// Shimmer Colors
  final Color highlightColor = Colors.grey.shade100;
  final Color baseColor = Colors.grey.shade300;

/// Dark Theme
  final Color darkMain = Colors.deepPurple;
  final Color darkFirst = const Color(0xff303030);
  //final Color darkFirst = const Color(0xff424242);
  final Color darkSecond = Colors.grey.shade900;
  //final Color darkSecond = const Color(0xff303030);
  final Color darkThirty = const Color(0xff1a1a1a);
  //final Color darkThirty = const Color(0xff1a1a1a);
  final Color darkForty = Colors.black54;


/// LightTheme
  //final Color lightMainColor = const Color(0xFF333333);
  final Color lightMain = Colors.indigo;
  final Color lightFirst = const Color(0xffCC7D00);
  final Color lightSecond = const Color(0xff7B7B7B);
  final MaterialColor lightThirty = Colors.red;


/// HelperColors
  final Color helperGrey300 = Colors.grey.shade300;
  final Color helperGrey200 = Colors.grey.shade200;
  final Color helperGrey600 = Colors.grey.shade600;
  final Color helperGrey900 = Colors.grey.shade900;
  final Color helperWhite = const Color(0xffFFFFFF);
  final Color whiteOne = const Color(0xffF6F6F6);
  final Color whiteTwo = Colors.black12.withOpacity(0.05);
  final Color helperTransparent = Colors.transparent;
  final MaterialColor grey = Colors.grey;
  final Color helperBlack = const Color(0xff1a1a1a);


  /// Cursor Color for TextField
  final MaterialColor cursorColor = Colors.deepOrange;
}