import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Authentication/Login/init_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MobileLoginPage extends StatelessWidget  {
  final InitLogin state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final ThemeData theme;
  final bool isDark;
  final UserModel userModel;
  final SharedPreferences preferences;


  const MobileLoginPage({
    Key? key ,
    required this.state ,
    required this.ref ,
    required this.keyBoard ,
    required this.connected ,
    required this.height ,
    required this.mediaQ ,
    required this.isDark ,
    required this.theme ,
    required this.userModel ,
    required this.preferences
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Form(
          key: state.main.formState ,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ListView(
                  children: [

                    /// Space
                    SizedBox(height: keyBoard ? constraints.maxHeight * 0.1 : mediaQ.size.height * 0.1) ,

                    /// Icon
                    state.mobile.buildIcon(
                        size: mediaQ.size,
                        context: context,
                        constraints: constraints,
                        keyBoard: keyBoard,
                        state: state
                    ) ,


                    /// Space
                    SizedBox(height: keyBoard ? constraints.maxHeight * 0.05 : mediaQ.size.height * 0.05) ,


                    /// name
                    state.mobile.buildTitle(
                        size: mediaQ.size,
                        context: context,
                        constraints: constraints,
                        keyBoard: keyBoard,
                        state: state
                    ) ,



                    /// TextField and Button
                    state.mobile.buildAuthTextFieldAndButton(
                        size: mediaQ.size,
                        context: context,
                        constraints: constraints,
                        keyBoard: keyBoard,
                        state: state,
                        onSubmitted: (v) async {
                          await state.main.userLogin(
                              controller: state.main.controller,
                              context: context ,
                              ref: ref ,
                              preferences: preferences ,
                              userModel: userModel
                          );
                        },
                        onPressed: () async {
                            await state.main.userLogin(
                                controller: state.main.controller ,
                                context: context ,
                                ref: ref ,
                                userModel: userModel ,
                                preferences: preferences
                            );
                         }
                    )


                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}
