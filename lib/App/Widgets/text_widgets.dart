import 'package:commerce/App/app.dart';
import 'package:flutter/material.dart';


abstract class BaseTextWidgets {



  Text text(String text , BuildContext context , {
    int? maxLine ,
    TextStyle? style ,
    TextOverflow? overflow ,
    double? fontSize ,
    FontWeight? fontWeight ,
    Color? color ,
    TextDecoration? decoration
  });

  Text translateText(
      String text,
      BuildContext context, {
        int? maxLine ,
        TextStyle? style ,
        TextOverflow? overflow ,
        double? fontSize ,
        FontWeight? fontWeight ,
        Color? color ,
        TextDecoration? decoration
      });




  FittedBox fittedText(
      text , {
        int? maxLine ,
        TextStyle? style ,
        TextOverflow? overflow ,
        double? fontSize ,
        FontWeight? fontWeight ,
        Color? color ,
        TextDecoration? decoration
      });


  AnimatedDefaultTextStyle animatedText({
    required String text ,
    int? maxLine ,
    TextStyle? style ,
    TextOverflow? overflow ,
    double? fontSize ,
    FontWeight? fontWeight ,
    Color? color ,
    TextDecoration? decoration
  });


  AnimatedCrossFade condition({
    required bool state ,
    required Widget first ,
    required Widget second,
    Alignment? alignment,
    Duration? duration , reverseDuration ,
    Curve? firstCurve , Curve? secondCurve , Curve? sizeCurve
  });

  FittedBox icon(IconData icon);

}


class TextWidget implements BaseTextWidgets {

  @override
  Text text(String text , BuildContext context ,{
    int? maxLine ,
    TextStyle? style ,
    TextOverflow? overflow ,
    double? fontSize ,
    FontWeight? fontWeight ,
    Color? color ,
    TextDecoration? decoration ,

  }) {
    return Text(
        text ,
        style: style ??  TextStyle(
            fontFamily: 'Lato',
            fontSize: fontSize ?? 15.0,
            fontWeight: fontWeight ,
            color: color ?? Theme.of(context).textTheme.displaySmall!.color,
            decoration: decoration ?? TextDecoration.none
        ),
        maxLines: maxLine ?? 1 ,
        overflow: overflow ?? TextOverflow.ellipsis
    );
  }

  @override
  FittedBox fittedText(
      text , {
        int? maxLine ,
        TextStyle? style ,
        TextOverflow? overflow ,
        double? fontSize ,
        FontWeight? fontWeight ,
        Color? color ,
        TextDecoration? decoration
      }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
          text ,
          style: style ??  TextStyle(
              fontFamily: 'Lato',
              fontSize: fontSize ?? 15.0,
              fontWeight: fontWeight ,
              color: color,
              decoration: decoration ?? TextDecoration.none
          ),
          maxLines: maxLine ?? 1 ,
          overflow: overflow ?? TextOverflow.ellipsis
      ),
    );
  }


  @override
  AnimatedDefaultTextStyle animatedText({
    required String text ,
    int? maxLine ,
    TextStyle? style ,
    TextOverflow? overflow ,
    double? fontSize ,
    FontWeight? fontWeight ,
    Color? color ,
    TextDecoration? decoration
  }) {
    return AnimatedDefaultTextStyle(
      maxLines: maxLine ?? 1 ,
      style: style ?? TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight ,
          overflow: overflow ?? TextOverflow.ellipsis ,
          decoration: decoration ?? TextDecoration.none
      ),
      duration: const Duration(milliseconds: 300),
      child: Text(
        text,
      ),
    );
  }


  @override
  AnimatedCrossFade condition({
    required Widget first , required Widget second,
    required bool state ,
    Alignment? alignment,
    Duration? duration , reverseDuration ,
    Curve? firstCurve , Curve? secondCurve , Curve? sizeCurve
}) {
    return AnimatedCrossFade(
        firstChild: first ,
        secondChild: second ,
        crossFadeState: state ? CrossFadeState.showFirst : CrossFadeState.showSecond ,
        secondCurve: secondCurve ?? Curves.linear ,
        sizeCurve: sizeCurve ?? Curves.linear ,
        firstCurve: firstCurve ?? Curves.linear,
        duration: duration ?? const Duration(milliseconds: 300),
        reverseDuration: reverseDuration ?? duration ,
        alignment: alignment ?? Alignment.topCenter
    );
  }

  @override
  FittedBox icon(IconData icon) {
    return FittedBox(
      fit: BoxFit.scaleDown ,
      child: Icon(icon),
    );
  }


  @override
  Text translateText(
    String text,
    BuildContext context, {
        int? maxLine ,
        TextStyle? style ,
        TextOverflow? overflow ,
        double? fontSize ,
        FontWeight? fontWeight ,
        Color? color ,
        TextDecoration? decoration
  }) {
    return Text("${App.localization.translate(
        context: context,
        text: text)}" ,
          style: style ??  TextStyle(
          fontFamily: 'Lato',
          fontSize: fontSize ?? 15.0,
          fontWeight: fontWeight ,
          color: color ?? Theme.of(context).textTheme.displaySmall!.color,
          decoration: decoration ?? TextDecoration.none
      ),

    );
  }


}