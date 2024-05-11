import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Authentication/ChangePw/init_change_pw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseChangePwState {


  //final userProv = FutureProvider((ref) => App.profile.getUserModel());

  final List<TextEditingController> controller = <TextEditingController>[
    TextEditingController() , /// Name
    TextEditingController(), /// OldPassword
    TextEditingController(), /// NewPassword
    TextEditingController(), /// ConfirmPassword
  ];

  final visibleOldPwProv = ChangeNotifierProvider((ref) => BooleanProvider());
  final visibleNewPwProv = ChangeNotifierProvider((ref) => BooleanProvider());
  final visibleConfirmNewPwProv = ChangeNotifierProvider((ref) => BooleanProvider());


  Future<void> updateState({
    required List<TextEditingController> controller ,
    required BuildContext context ,
    required WidgetRef ref ,
    required UserModel model ,
    required InitChangePw state
  });


}

class ChangePwState extends BaseChangePwState {


  @override
  Future<void> updateState({
    required List<TextEditingController> controller ,
    required BuildContext context ,
    required WidgetRef ref ,
    required UserModel model ,
    required InitChangePw state
  }) async {

    if(
    /// don't Forget Model Name
        controller.elementAt(0).text.isEmpty
        ||
        controller.elementAt(0).text == model.name
        ||
        controller.elementAt(1).text.isEmpty
        &&
        controller.elementAt(2).text.isEmpty
        &&
        controller.elementAt(3).text.isEmpty
    ) {

      App.navigator.backPageRouter(context: context);

    } else if(
        controller.elementAt(1).text.isEmpty
        &&
        controller.elementAt(2).text.isEmpty
        &&
        controller.elementAt(3).text.isEmpty
        &&
        controller.elementAt(0).text.isNotEmpty
        ||
        controller.elementAt(0).text != model.name
    ) {

      await _changePw(context);

    }
    else {
      if(controller.elementAt(1).text == "Model.oldPassword") {
        if(controller.elementAt(2).text == controller.elementAt(3).text) {

          await _changePw(context);

        } else {

          App.alertWidgets.snackBar(text: "New Password and Confirm aren't right", context: context);

        }
      } else {

        App.alertWidgets.snackBar(text: "Old Password isn't right", context: context);

      }
    }
  }

  _changePw(BuildContext context) {
    return Controller.auth.changePw(
        controller: controller,
        context: context
    );
  }

}