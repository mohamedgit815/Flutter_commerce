import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Authentication/Login/init_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseMobileLoginWidgets {
  Widget buildIcon({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitLogin state
  });

  Widget buildTitle({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitLogin state
  });

  Widget buildAuthTextFieldAndButton({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitLogin state ,
    required ValueChanged<String>? onSubmitted ,
    required VoidCallback onPressed
  });
}





class MobileLoginWidgets implements BaseMobileLoginWidgets {
  @override
  Widget buildIcon({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitLogin state
  }) {
    return SizedBox(
        height: keyBoard ? constraints.maxHeight *  0.2 : size.height * 0.2,
        child: Image.asset(
            App.strings.icon ,
            fit: BoxFit.scaleDown
        )
    );
  }


  @override
  Widget buildTitle({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitLogin state
  }) {
    return SizedBox(
      height: keyBoard ? constraints.maxHeight * 0.15 : size.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround ,
        children: [

          Expanded(
            child: App.text.text(
                'Hello Again!',
                context ,
                fontSize: 30.0 ,
                fontWeight: FontWeight.bold
            ),
          ) ,

          Expanded(
            child: App.text.text(
                'welcome back, you\'ve been missed!',
                context ,
                fontSize: 18.0 ,
                fontWeight: FontWeight.normal
            ),
          )

        ],
      ),
    );
  }



  @override
  Widget buildAuthTextFieldAndButton({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitLogin state ,
    required ValueChanged<String>? onSubmitted ,
    required VoidCallback onPressed
  }) {
    return SizedBox(
      height: keyBoard ? constraints.maxHeight * 0.35 : size.height * 0.35,
      child: Column(
        children: [

          const Spacer(flex: 3) ,

          Expanded(
              flex: 8,
              child: App.globalWidgets.authFormField(
                  controller: state.main.controller.elementAt(0) , /// Email
                  validator: (v) {
                    return App.validator.validatorEmail(v);
                  },
                  inputAction: TextInputAction.next ,
                  inputType: TextInputType.emailAddress ,
                  context: context,
                  hint: "Email"
              )
          ) ,

          const Spacer() ,

          Expanded(
              flex: 8,
              child: Consumer(
                  builder: (context, prov, _) {
                    return App.globalWidgets.authFormField(
                        controller: state.main.controller.elementAt(1) , /// Pw
                        inputAction: TextInputAction.done ,
                        inputType: TextInputType.visiblePassword,
                        context: context ,
                        hint: "Password" ,
                        password: prov.watch(state.main.visiblePwProv).boolean ,
                        suffixIcon: IconButton(
                            onPressed: () {
                              prov.read(state.main.visiblePwProv).switchBoolean();
                            },
                            icon: App.text.condition(
                                state: prov.read(state.main.visiblePwProv).boolean ,
                                first: const Icon(Icons.visibility_off),
                                second: const Icon(Icons.visibility)
                            )
                        ),
                        validator: (v) {
                          return App.validator.validatorName(v);
                        },
                        onSubmitted: onSubmitted
                    );
                  }
              )
          ) ,

          const Spacer(flex: 2) ,

          Expanded(
            flex: 10,
            child: App.globalWidgets.expanded(
              child: Consumer(
                builder: (context, prov, _) {
                  return App.packageWidgets.condition(
                      duration: const Duration(milliseconds: 100) ,

                      condition: !prov.watch(state.main.loadingProv).boolean ,

                      builder: (BuildContext context) {
                        return App.globalWidgets.loadingWidget();
                      } ,

                      fallback: (context) {
                        return App.buttons.elevated(
                            onPressed: onPressed ,

                            size: const Size.fromHeight(double.infinity),

                            borderRadius: BorderRadius.circular(15.0),

                            child: App.text.text(
                                "Sign in",
                                context,
                                color: App.color.helperWhite ,
                                fontSize: 24.0
                            )
                        );
                      }
                  );
                }
              ),
            ),
          ) ,

          const Spacer(flex: 2) ,

          Expanded(
            flex: 3 ,
            child: GestureDetector(
              onTap: () {
                state.main.navigateToRegisterScreen(context);
              },
              child: RichText(
                text: TextSpan(
                    text: "didn't you have an Account? " ,
                    style: TextStyle(color: App.color.helperBlack,fontWeight: FontWeight.bold),
                    children: [
                      //const TextSpan(text: ""),
                      TextSpan(
                          text: "Sign up",
                          style: TextStyle(color: App.color.lightMain,fontSize: 17.0)
                      ),
                    ]
                ),

              ),
            ),
          ) ,

          const Spacer(flex: 3)

        ],
      ),
    );
  }
}