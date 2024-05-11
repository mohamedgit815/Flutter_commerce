import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseGlobalHelper {
  /// To Hide The Keyboard for Screen
  void unFocusKeyBoard({required BuildContext context});


  /// Check Keyboard if Hide or No
  bool checkKeyboard(BuildContext context);


  /// NotificationListener
  bool notificationListener({
    required UserScrollNotification notification ,
    required WidgetRef ref ,
    required ProviderListenable<BooleanProvider> providerListenable
  });


  /// To Ask User if he wants to exit Application or No
  Future<bool> customExitApp({required DateTime dateTime});

  /// to know the direction of languages
  TextDirection directionText(String v);
}


class GlobalHelper implements BaseGlobalHelper {

  @override
  TextDirection directionText(String v) {
    final string = v.trim();
    if (string.isEmpty) return TextDirection.ltr;
    final firstUnit = string.codeUnitAt(0);
    if (firstUnit > 0x0600 && firstUnit < 0x06FF ||
        firstUnit > 0x0750 && firstUnit < 0x077F ||
        firstUnit > 0x07C0 && firstUnit < 0x07EA ||
        firstUnit > 0x0840 && firstUnit < 0x085B ||
        firstUnit > 0x08A0 && firstUnit < 0x08B4 ||
        firstUnit > 0x08E3 && firstUnit < 0x08FF ||
        firstUnit > 0xFB50 && firstUnit < 0xFBB1 ||
        firstUnit > 0xFBD3 && firstUnit < 0xFD3D ||
        firstUnit > 0xFD50 && firstUnit < 0xFD8F ||
        firstUnit > 0xFD92 && firstUnit < 0xFDC7 ||
        firstUnit > 0xFDF0 && firstUnit < 0xFDFC ||
        firstUnit > 0xFE70 && firstUnit < 0xFE74 ||
        firstUnit > 0xFE76 && firstUnit < 0xFEFC ||
        firstUnit > 0x10800 && firstUnit < 0x10805 ||
        firstUnit > 0x1B000 && firstUnit < 0x1B0FF ||
        firstUnit > 0x1D165 && firstUnit < 0x1D169 ||
        firstUnit > 0x1D16D && firstUnit < 0x1D172 ||
        firstUnit > 0x1D17B && firstUnit < 0x1D182 ||
        firstUnit > 0x1D185 && firstUnit < 0x1D18B ||
        firstUnit > 0x1D1AA && firstUnit < 0x1D1AD ||
        firstUnit > 0x1D242 && firstUnit < 0x1D244) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }


  @override
  void unFocusKeyBoard({required BuildContext context}) {
    return App.navigator.navigatorKey.currentState!.focusNode.unfocus();
  }
 // bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;


  @override
  bool checkKeyboard(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }



  @override
  bool notificationListener({
    required UserScrollNotification notification ,
    required WidgetRef ref ,
    required ProviderListenable<BooleanProvider> providerListenable
  }) {
    if(notification.direction == ScrollDirection.forward) {
      ref.read(providerListenable).trueBoolean();
    } else if(notification.direction == ScrollDirection.reverse) {
      ref.read(providerListenable).falseBoolean();
    }
    return true;
  }


  @override
  Future<bool> customExitApp({required DateTime dateTime}) async {
    final Duration varDifference = DateTime.now().difference(dateTime);
    final isExitWarning = varDifference >= const Duration(seconds: 2);
    dateTime = DateTime.now();

    if(isExitWarning){
      // await Fluttertoast.showToast(msg: 'Press back again to exit',fontSize: 17.0);
      return false;
    }else{
      // await Fluttertoast.cancel();
      return true;
    }
  }

}