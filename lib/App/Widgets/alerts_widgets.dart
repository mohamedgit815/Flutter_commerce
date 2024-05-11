import 'package:commerce/App/app.dart';
import 'package:flutter/material.dart';


abstract class BaseAlertWidgets {
  ScaffoldMessengerState snackBar({
    required String text,
    required BuildContext context ,
    final BorderRadius? borderRadius ,
    final EdgeInsets? padding ,
    final Duration? duration ,
    final SnackBarAction? snackBarAction ,
    final bool? translate
  });

  Future<void> showAlertDialog({
    required BuildContext context ,
    required Widget Function(BuildContext) builder
  });

  Future<void> globalAlertDialog({
    required VoidCallback onPressed ,
    required BuildContext context  ,
    Widget? content
  });

  Future<void> modalBottomSheet({
    required Widget widgets ,
    required BuildContext context
  });

  ScaffoldMessengerState materialBanner({
    required BuildContext context ,
    required String text ,
    required List<Widget> actions ,
    Widget? leading
  });
}


class AlertWidgets implements BaseAlertWidgets {
  @override
  ScaffoldMessengerState snackBar({
    required String text,
    required BuildContext context ,
    final BorderRadius? borderRadius ,
    final EdgeInsets? padding ,
    final Duration? duration ,
    final SnackBarAction? snackBarAction ,
    final bool? translate
  }) {
    return ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(
        SnackBar(
            content: translate?? false ? App.text.text(text, context) : App.text.translateText(text, context),
            //content: App.text.text(text, context),
            shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(0.0)),
            padding: padding ,
            duration: duration ?? const Duration(seconds: 1) ,
            action: snackBarAction
        ));
  }

  @override
  Future<void> globalAlertDialog({
    required VoidCallback onPressed ,
    required BuildContext context ,
    Widget? content
  }) {
    return showDialog(context: context, builder: (buildContext)=>AlertDialog(
      title: App.text.text('Are you Sure ?',context) ,
      content: content ,
      actions: [
        App.buttons.elevated(
            onPressed: (){
              Navigator.pop(context);
            }, child: const Text('No')),
        //child: Text('${context.translate!.translate(MainEnum.textNo.name)}')),
        App.buttons.elevated(
            onPressed: onPressed, child: const Text('Yes')),
      ],
    ));
  }

  @override
  Future<void> showAlertDialog({
    required BuildContext context ,
    required Widget Function(BuildContext) builder
  })
  async {
    return await showAdaptiveDialog(context: context, builder: builder);
  }


  @override
  Future<void> modalBottomSheet({
    required Widget widgets ,
    required BuildContext context
  }) async {
    return await showModalBottomSheet(context: context, builder: (buildContext)=>widgets);
  }


  @override
  ScaffoldMessengerState materialBanner({
    required BuildContext context ,
    required String text ,
    required List<Widget> actions ,
    Widget? leading
  }) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(MaterialBanner(
          leading: leading ,
          content: Text(text) ,
          actions: actions
      ));
  }

}
