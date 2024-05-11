import 'package:flutter/material.dart';

abstract class BaseButtonsWidgets {

  IconButton icon({required VoidCallback onPressed ,required Widget icon});

  TextButton text({
    required VoidCallback onPressed ,
    required Widget child ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor
});

  TextButton textIcon({
    required VoidCallback onPressed ,
    required Widget child ,
    required Widget icon ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor
  });


  OutlinedButton outline({
    required VoidCallback onPressed ,
    required Widget child ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor ,
    BorderSide? borderSide
  });

  OutlinedButton outlineIcon({
    required VoidCallback onPressed ,
    required Widget child ,
    required Widget icon ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor ,
    BorderSide? borderSide
  });


  ElevatedButton elevated({
    required VoidCallback onPressed ,
    required Widget child ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Color? backGroundColor ,
    Size? size
  });

  ElevatedButton elevatedIcon({
    required VoidCallback onPressed ,
    required Widget child ,
    required Widget icon ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Color? backGroundColor ,
    Size? size
  });

}

class ButtonsWidgets implements BaseButtonsWidgets {

  @override
  IconButton icon({required VoidCallback onPressed , required Widget icon}) {
    return IconButton(onPressed: onPressed , icon: icon);
  }


  @override
  TextButton text({
    required VoidCallback onPressed ,
    required Widget child ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        elevation: elevation,
        minimumSize: size,
        backgroundColor: backGroundColor,
        textStyle: const TextStyle(fontSize: 17.0),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(0)
        ),
      ),
      child: child ,
    );
  }

  @override
  TextButton textIcon({
    required VoidCallback onPressed ,
    required Widget child ,
    required Widget icon ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        elevation: elevation,
        minimumSize: size,
        backgroundColor: backGroundColor,
        textStyle: const TextStyle(fontSize: 17.0),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(0)
        ),
      ),
      label: child,
      icon: icon ,
    );
  }




  @override
  OutlinedButton outline({
    required VoidCallback onPressed ,
    required Widget child ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor ,
    BorderSide? borderSide
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        elevation: elevation,
        minimumSize: size,
        side: borderSide ?? const BorderSide(),
        backgroundColor: backGroundColor,
        textStyle: const TextStyle(fontSize: 17.0),
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.red,width: 100,style: BorderStyle.solid),
            borderRadius: borderRadius ?? BorderRadius.circular(0) ,
        ),
      ),
      child: child ,
    );
  }


  @override
  OutlinedButton outlineIcon({
    required VoidCallback onPressed ,
    required Widget child ,
    required Widget icon ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Size? size ,
    Color? backGroundColor ,
    BorderSide? borderSide
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        side: borderSide ?? const BorderSide(),
        elevation: elevation,
        minimumSize: size,
        backgroundColor: backGroundColor,
        textStyle: const TextStyle(fontSize: 17.0),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(0)
        ),
      ),
      label: child ,
      icon: icon ,
    );
  }


  @override
  ElevatedButton elevated({
    required VoidCallback onPressed ,
    required Widget child ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Color? backGroundColor ,
    Size? size,
    BorderSide? borderSide
  }) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          side: borderSide ,
          backgroundColor: backGroundColor,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        child: child
    );
  }


  @override
  ElevatedButton elevatedIcon({
    required VoidCallback onPressed ,
    required Widget child ,
    required Widget icon ,
    EdgeInsets? padding ,
    double? elevation ,
    BorderRadius? borderRadius ,
    Color? backGroundColor ,
    Size? size
  }) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        label: child ,
      icon: icon ,
    );
  }
}