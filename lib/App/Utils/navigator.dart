import 'package:commerce/App/app.dart';
import 'package:flutter/material.dart';



abstract class BaseAppNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  Future<dynamic> backPageRouter({required BuildContext context, dynamic arguments});


  String pushNamedRouter({required String route ,required BuildContext context,dynamic arguments});


  String pushNamedAndReplaceRouter({required BuildContext context,required String route ,dynamic arguments});


  String pushNamedAndRemoveRouter({required String route ,required BuildContext context,dynamic arguments});
}


class AppNavigator implements BaseAppNavigator {

   @override
   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


   @override
   Future<dynamic> backPageRouter({required BuildContext context, dynamic arguments}) async {
    return await navigatorKey.currentState!.maybePop(arguments);
   }


  @override
  String pushNamedRouter({required String route ,required BuildContext context,dynamic arguments}) {
    return navigatorKey.currentState!.restorablePushNamed(route,arguments: arguments);
  }


  @override
  String pushNamedAndReplaceRouter({required String route ,required BuildContext context,dynamic arguments}) {
    return navigatorKey.currentState!.restorablePushReplacementNamed(route,arguments: arguments);
  }


  @override
  String pushNamedAndRemoveRouter({required String route ,required BuildContext context,dynamic arguments}) {
    return navigatorKey.currentState!.restorablePushNamedAndRemoveUntil(route , (route) => false,arguments: arguments);
  }

}


abstract class BaseAppValidator {
  String? validatorName(String? v,{String? message});

  String? validatorEmail(String? v,{String? message});

  String? validatorPhone(String? v,{String? message});

  String? validatorPw(String? v,{String? message});

  String? validatorNumber(String? v,{String? message});
}


class AppValidator implements BaseAppValidator {
  @override
  String? validatorName(String? v,{String? message}) {
    return !v!.contains(App.regExp.regExpName) ? message ?? 'Enter your Name' : null ;
  }

  @override
  String? validatorEmail(String? v,{String? message}) {
    return !v!.contains(App.regExp.regExpEmail) ? message ?? 'Enter your Email' : null ;
  }

  @override
  String? validatorPhone(String? v,{String? message}) {
    return !v!.contains(App.regExp.regExpPhone) ? message ?? 'Enter your Phone' : null;
  }

  @override
  String? validatorPw(String? v,{String? message}) {
    return !v!.contains(App.regExp.regExpPw) ? message ?? '[UpperCase , LowerCase , \$ ,# ,%]' : null;
  }

  @override
  String? validatorNumber(String? v,{String? message}) {
    return !v!.contains(App.regExp.numberRegExp) ? message ?? 'Only Enter Numbers' : null;

  }
}