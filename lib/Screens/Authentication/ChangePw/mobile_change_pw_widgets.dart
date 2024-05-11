import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Authentication/ChangePw/init_change_pw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseMobileChangePwWidgets {
  Widget buildTitle({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitChangePw state
  });

  Widget buildAuthTextFieldAndButton({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitChangePw state ,
    required ValueChanged<String>? onSubmitted ,
    required VoidCallback onPressed
  });
}








class MobileChangePwWidgets implements BaseMobileChangePwWidgets {

  @override
  Widget buildTitle({
    required Size size ,
    required BuildContext context ,
    required BoxConstraints constraints ,
    required bool keyBoard ,
    required InitChangePw state
  }) {
    return SizedBox(
      height: keyBoard ? constraints.maxHeight * 0.15 : size.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround ,
        children: [

          Expanded(
            child: App.text.text(
                'Email@gmail.com',
                context ,
                fontSize: 30.0 ,
                fontWeight: FontWeight.bold
            ),
          ) ,

          Expanded(
            child: App.text.text(
                'you can update your Profile Data',
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
    required InitChangePw state ,
    required ValueChanged<String>? onSubmitted ,
    required VoidCallback onPressed
  }) {
    return SizedBox(
      height: keyBoard ? constraints.maxHeight * 0.55 : size.height * 0.55,
      child: Column(
        children: [

          const Spacer(flex: 3) ,

          Expanded(
              flex: 8 ,
              child: App.globalWidgets.authFormField(
                  controller: state.main.controller.elementAt(0) , /// Name
                  inputAction: TextInputAction.next ,
                  inputType: TextInputType.text,
                  context: context,
                  hint: "Full Name"
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
                        hint: "Old Password" ,
                        password: prov.watch(state.main.visibleOldPwProv).boolean ,
                        suffixIcon: IconButton(
                            onPressed: () {
                              prov.read(state.main.visibleOldPwProv).switchBoolean();
                            },
                            icon: App.text.condition(
                                state: prov.read(state.main.visibleOldPwProv).boolean ,
                                first: const Icon(Icons.visibility_off),
                                second: const Icon(Icons.visibility)
                            )
                        ),
                        onSubmitted: onSubmitted
                    );
                  }
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
                        hint: "New Password" ,
                        password: prov.watch(state.main.visibleNewPwProv).boolean ,
                        suffixIcon: IconButton(
                            onPressed: () {
                              prov.read(state.main.visibleNewPwProv).switchBoolean();
                            },
                            icon: App.text.condition(
                                state: prov.read(state.main.visibleNewPwProv).boolean ,
                                first: const Icon(Icons.visibility_off),
                                second: const Icon(Icons.visibility)
                            )
                        ),
                        onSubmitted: onSubmitted
                    );
                  }
              )
          ) ,

          const Spacer() ,

          Expanded(
              flex: 8,
              child: Consumer(
                  builder: (context, prov, _) {
                    return App.globalWidgets.authFormField(
                        controller: state.main.controller.elementAt(3) , /// Pw
                        inputAction: TextInputAction.done ,
                        inputType: TextInputType.visiblePassword,
                        context: context ,
                        hint: "Confirm New Password" ,
                        password: prov.watch(state.main.visibleConfirmNewPwProv).boolean ,
                        suffixIcon: IconButton(
                            onPressed: () {
                              prov.read(state.main.visibleConfirmNewPwProv).switchBoolean();
                            },
                            icon: App.text.condition(
                                state: prov.read(state.main.visibleConfirmNewPwProv).boolean ,
                                first: const Icon(Icons.visibility_off),
                                second: const Icon(Icons.visibility)
                            )
                        ),
                        onSubmitted: onSubmitted
                    );
                  }
              )
          ) ,

          const Spacer(flex: 2) ,

          Expanded(
            flex: 10,
            child: App.globalWidgets.expanded(
              child: App.buttons.elevated(
                  onPressed: onPressed ,

                  size: const Size.fromHeight(double.infinity),

                  borderRadius: BorderRadius.circular(15.0),

                  child: App.text.text(
                      "Update Profile",
                      context,
                      color: App.color.helperWhite ,
                      fontSize: 24.0
                  )
              ),
            ),
          ) ,


          const Spacer(flex: 3)

        ],
      ),
    );
  }

}