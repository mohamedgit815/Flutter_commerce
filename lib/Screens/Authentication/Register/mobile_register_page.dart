import 'package:commerce/Screens/Authentication/Register/init_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileRegisterPage extends StatelessWidget  {
  final InitRegister state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final ThemeData theme;
  final bool isDark;


  const MobileRegisterPage({
    Key? key ,
    required this.state ,
    required this.ref ,
    required this.keyBoard ,
    required this.connected ,
    required this.height ,
    required this.mediaQ ,
    required this.isDark ,
    required this.theme
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
                  SizedBox(height: keyBoard ? constraints.maxHeight * 0.15 : mediaQ.size.height * 0.15) ,


                  /// name
                  state.mobile.buildTitle(
                      size: mediaQ.size ,
                      context: context ,
                      constraints: constraints ,
                      keyBoard: keyBoard ,
                      state: state
                  ) ,


                  /// TextField and Button
                  state.mobile.buildAuthTextFieldAndButton(
                      size: mediaQ.size ,
                      context: context ,
                      constraints: constraints ,
                      keyBoard: keyBoard ,
                      state: state ,
                      onSubmitted: (v) async {
                        await state.main.createAccount(
                            controller: state.main.controller ,
                            context: context
                        );
                      } ,
                      onPressed: () async {
                        await state.main.createAccount(
                            controller: state.main.controller ,
                            context: context
                        );
                      }
                  ) ,

                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
