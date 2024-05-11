import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseRegisterState {
  final List<TextEditingController> controller = [
    TextEditingController() , /// Name[Index=0]
    TextEditingController() , /// Email[Index=1]
    TextEditingController() , /// Password[Index=2]
  ];

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final visiblePwProv = ChangeNotifierProvider.autoDispose((ref) => BooleanProvider()) ;


  Future<void> createAccount({
    required List<TextEditingController> controller,
    required BuildContext context
  });

  void backButton(BuildContext context);

}









class RegisterState extends BaseRegisterState {

  @override
  Future<void> createAccount({
    required List<TextEditingController> controller,
    required BuildContext context
  }) async {
    return await Controller.auth.createAccount(
        controller: controller ,
        context: context
    ).then((value) {
      Navigator.maybePop(context);
      //Navigator.of(context).push(CupertinoPageRoute(builder: (_)=> ));
      //Navigator.pushNamedAndRemoveUntil(context, RouteGenerators.loginScreen, (route) => false);
    });
  }


  @override
  void backButton(BuildContext context) {
    Navigator.maybePop(context);
  }

}