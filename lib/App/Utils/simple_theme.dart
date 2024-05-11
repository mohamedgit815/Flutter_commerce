import 'package:flutter/material.dart';

abstract class BaseSimpleThemeData {
  Color conditionTheme({
    required BuildContext context ,
    required Color light ,
    required Color dark
  });
}

class SimpleThemeData extends BaseSimpleThemeData {
  @override
  Color conditionTheme({
    required BuildContext context ,
    required Color light ,
    required Color dark
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if(isDark) {
      return dark;
    } else {
      return light;
    }
  }




  ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      brightness: Brightness.light ,
      colorScheme: ColorScheme.light(
        background: Colors.grey.shade300 ,
        primary: Colors.grey.shade200 ,
        secondary: Colors.white ,
        inversePrimary: Colors.grey.shade700 ,
      )
    );
  }



  ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark ,
        colorScheme: ColorScheme.dark(
          background: Colors.grey.shade300 ,
          primary: Colors.grey.shade200 ,
          secondary: Colors.white ,
          inversePrimary: Colors.grey.shade700 ,
        )
    );
  }
}