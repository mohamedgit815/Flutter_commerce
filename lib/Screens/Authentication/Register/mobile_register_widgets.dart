import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Authentication/Register/init_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseMobileRegisterWidgets {
  Widget buildTitle({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitRegister state
  });

  Widget buildAuthTextFieldAndButton({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitRegister state ,
    required ValueChanged<String>? onSubmitted ,
    required VoidCallback onPressed
  });
}










class MobileRegisterWidgets implements BaseMobileRegisterWidgets {

  @override
  Widget buildTitle({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitRegister state
}) {
    return SizedBox(
      height: keyBoard ? constraints.maxHeight * 0.15 : size.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround ,
        children: [

          Expanded(
            child: App.text.text(
                'Register',
                context ,
                fontSize: 30.0 ,
                fontWeight: FontWeight.bold
            ),
          ) ,

          Expanded(
            child: App.text.text(
                'Please Register to Login',
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
    required InitRegister state ,
    required ValueChanged<String>? onSubmitted ,
    required VoidCallback onPressed
  }) {
    return SizedBox(
      height: keyBoard ? constraints.maxHeight * 0.55 : size.height * 0.55,
      child: Column(
        children: [

          const Spacer(flex: 3) ,

          Expanded(
              flex: 8,
              child: App.globalWidgets.authFormField(
                  controller: state.main.controller.elementAt(0) , /// Name
                  validator: (v) {
                    return App.validator.validatorName(v);
                  },
                  inputAction: TextInputAction.next ,
                  inputType: TextInputType.text,
                  context: context,
                  hint: "Full Name"
              )
          ) ,

          const Spacer() ,

          Expanded(
              flex: 8,
              child: App.globalWidgets.authFormField(
                  controller: state.main.controller.elementAt(1) , /// Email
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
                        controller: state.main.controller.elementAt(2) , /// Pw
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
              child: Consumer(
                builder: (context, prov, _) {

                  return App.globalWidgets.expanded(
                    child: App.packageWidgets.condition(
                        condition: false ,

                        duration: const Duration(milliseconds: 200) ,

                        builder: (BuildContext context) {
                          return App.globalWidgets.loadingWidget();
                        } ,

                        fallback: (BuildContext context) {
                          return App.buttons.elevated(
                              onPressed: onPressed,

                              size: const Size.fromHeight(double.infinity),

                              borderRadius: BorderRadius.circular(15.0),

                              child: App.text.text(
                                  "Sign up",
                                  context,
                                  color: App.color.helperWhite,
                                  fontSize: 24.0
                              )
                          );
                        }

                    ),
                  );
                }
              ),
          ) ,

          const Spacer(flex: 2) ,


          Expanded(
            flex: 3 ,
            child: GestureDetector(
              onTap: () {
                state.main.backButton(context);
              },
              child: RichText(
                text: TextSpan(
                    text: "Already have an Account? " ,
                    style: TextStyle(color: App.color.helperBlack,fontWeight: FontWeight.bold),
                    children: [
                      //const TextSpan(text: ""),
                      TextSpan(
                          text: "Sign in",
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