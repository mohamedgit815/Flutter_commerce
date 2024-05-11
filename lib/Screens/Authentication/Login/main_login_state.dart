import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class BaseLoginState {
  final visiblePwProv = ChangeNotifierProvider.autoDispose((ref) => BooleanProvider()) ;
  final loadingProv = ChangeNotifierProvider.autoDispose((ref) => BooleanProvider()) ;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  List<TextEditingController> controller = [
    TextEditingController() , /// Email[Index=0]
    TextEditingController() , /// Password[Index=1]
  ];


  void navigateToRegisterScreen(BuildContext context);


  Future<void> userLogin({
    required BuildContext context ,
    required WidgetRef ref ,
    required List<TextEditingController> controller ,
    required SharedPreferences preferences ,
    required UserModel userModel
  });
}

class LoginState extends BaseLoginState {

  @override
  void navigateToRegisterScreen(BuildContext context) {
    App.navigator.pushNamedRouter(
        route: RouteGenerators.registerScreen ,
        context: context
    );
  }

  @override
  Future<void> userLogin({
    required BuildContext context ,
    required List<TextEditingController> controller ,
    required WidgetRef ref,
    required SharedPreferences preferences ,
    required UserModel userModel
  }) async {
    ref.read(loadingProv).falseBoolean();
    return await Controller.auth.login(
        controller: controller ,
        preferences: preferences ,
        userModel: userModel ,
        context: context
    ).then((value) {
      ref.read(loadingProv).trueBoolean();
    }).catchError((e){
      ref.read(loadingProv).trueBoolean();
    });
  }

}