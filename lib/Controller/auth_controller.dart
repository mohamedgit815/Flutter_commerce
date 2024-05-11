import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/BottomBar/main_bottom_bar_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



abstract class BaseAuthController {

  Future<void> createAccount({
    required List<TextEditingController> controller,
    required BuildContext context
  });


  Future<void> login({
    required List<TextEditingController> controller,
    required BuildContext context ,
    required SharedPreferences preferences ,
    required UserModel userModel
  });


  Future<void> changePw({
    required List<TextEditingController> controller,
    required BuildContext context
  });
}


class AuthController extends BaseAuthController {
  @override
  Future<void> login({
    required List<TextEditingController> controller,
    required BuildContext context ,
    required SharedPreferences preferences ,
    required UserModel userModel
  }) async {
    FocusScope.of(context).unfocus();
    try{
      final Response response = await App.dio.post(
          url: App.strings.loginUrl ,
          data: {
            //"email": "medo@gmail.com" ,
            "email": controller.elementAt(0).text ,
            //"password": "123456789"
            "password": controller.elementAt(1).text
          }
          );



      if(response.statusCode == 200 || response.statusCode == 201) {



        /// Save data to Local into SharePreferences
       await App.profile.setUserModel(
            preferences: preferences,
            response: response
        );

       print(response.data);


        if(context.mounted) {
          App.alertWidgets.snackBar(text: LangEnum.success.name, context: context);

          await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (_) => MainBottomBarScreen(userModel: userModel)), (route) => false);
        }
      }

    }on DioException catch(_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.internet.name, context: context);
      }
    }
  }


  @override
  Future<void> createAccount({
    required List<TextEditingController> controller ,
    required BuildContext context
  }) async {
    try{
      final Response response = await App.dio.post(
          url: App.strings.registerUrl ,
          data: {
            "name": controller.elementAt(0).text ,
            "email": controller.elementAt(1).text ,
            "password": controller.elementAt(2).text
          });

      if(response.statusCode == 200 || response.statusCode == 201) {
        if(context.mounted) {
          App.alertWidgets.snackBar(text: LangEnum.success.name, context: context);
        }
      }


    }on DioException catch(_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.email.name, context: context);
      }
    }
  }


  @override
  Future<void> changePw({
    required List<TextEditingController> controller ,
    required BuildContext context
  }) async {
    try{
      final Response response = await App.dio.update(
          url: App.strings.updateProfileUrl ,
          data: {
            "name": controller.elementAt(0) ,
            "password": controller.elementAt(1) ,
          });

      if(response.statusCode == 200 || response.statusCode == 201) {
        if(context.mounted) {
          App.alertWidgets.snackBar(text: LangEnum.success.name, context: context);

        }
      }


    }on DioException catch(_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.email.name, context: context);

      }

    }
  }
}