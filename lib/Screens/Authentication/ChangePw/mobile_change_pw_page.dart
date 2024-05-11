import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Authentication/ChangePw/init_change_pw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileChangePwPage extends StatelessWidget  {
  final InitChangePw state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final ThemeData theme;
  final bool isDark;

  const MobileChangePwPage({Key? key ,
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
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(

        appBar: AppBar(
          elevation: 0 ,
          backgroundColor: App.color.helperGrey300 ,
          leading: const BackButton(),
        ),

        body: LayoutBuilder(
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
                        return await state.main.updateState(
                            controller: state.main.controller ,
                            context: context,
                            ref: ref,
                            model: const UserModel(id: "id", name: "name", email: "email", token: "token") ,
                            state: state
                        );
                      } ,

                      onPressed: () async {
                        return await state.main.updateState(
                            controller: state.main.controller ,
                            context: context,
                            ref: ref,
                            model: const UserModel(id: "id", name: "name", email: "email", token: "token") ,
                            state: state
                        );
                      }
                      //   await ref.read(state.main.changePwProv.notifier).changePw(
                      //       controller: state.main.controller,
                      //       context: context
                      //   );
                      // }
                  ) ,

                ],
              );
            }
        ),
      ),
    );
  }
}
