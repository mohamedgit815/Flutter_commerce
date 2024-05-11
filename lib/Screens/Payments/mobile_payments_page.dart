import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Payments/init_payments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobilePaymentsPage extends StatelessWidget  {
  final InitPayments state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final ThemeData theme;
  final bool isDark;
  final TotalAndCountModel totalAndCountModel;
  final UserModel userModel;

  const MobilePaymentsPage({
    Key? key ,
    required this.state ,
    required this.ref ,
    required this.keyBoard ,
    required this.connected ,
    required this.height ,
    required this.mediaQ ,
    required this.isDark ,
    required this.theme ,
    required this.totalAndCountModel ,
    required this.userModel
  }) : super(key: key);


  /// Paypal: sb-lvfwa4965414@personal.example.com
  /// Vise: 4242 4242 4242 4242
  /// MM/YY: 12/34
  /// CVC: 567
  /// Zip:123456789
  /// 1028195566

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        leading: const BackButton() ,
        title: App.text.translateText(LangEnum.purchase.name, context,fontSize: 24.0) ,
        elevation: 0 ,

      ),

      body: Form(
        key: state.main.formState ,
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              } ,

              child: ListView(
                children: [
                  //
                  // Visibility(
                  //   visible: false ,
                  //   child: SizedBox(
                  //     height: keyBoard ? constraints.maxHeight * 0.15 : mediaQ.size.height * 0.15 ,
                  //     child: App.globalWidgets.authFormField(
                  //         inputAction: TextInputAction.next ,
                  //         inputType: TextInputType.streetAddress,
                  //         context: context,
                  //         validator: (v) {
                  //           return App.validator.validatorName(v,message: 'Enter your City');
                  //         },
                  //         controller: state.main.controller.elementAt(0), /// City
                  //         hint: "City"
                  //         ),
                  //   ),
                  // ) ,
                  //
                  //
                  // Visibility(
                  //   visible: false ,
                  //   child: SizedBox(
                  //   height: keyBoard ? constraints.maxHeight * 0.15 : mediaQ.size.height * 0.15 ,
                  //     child: App.globalWidgets.authFormField(
                  //         inputAction: TextInputAction.next ,
                  //         inputType: TextInputType.number,
                  //         context: context,
                  //         validator: (v) {
                  //           return App.validator.validatorNumber(v,message: 'Enter your Zip');
                  //         },
                  //         controller: state.main.controller.elementAt(1), /// Zip
                  //         hint: "zip"
                  //         ),
                  //   ),
                  // ) ,


                  SizedBox(
                    height: keyBoard ? constraints.maxHeight * 0.15 : mediaQ.size.height * 0.15 ,
                    child: App.globalWidgets.authFormField(
                        inputAction: TextInputAction.next ,
                        inputType: TextInputType.phone,
                        context: context,
                        phone: false ,
                        controller: state.main.controller, /// Phone Number
                        hint: "Phone"
                        ),
                  ) ,

                  SizedBox(
                    height: keyBoard ? constraints.maxHeight * 0.1 : mediaQ.size.height * 0.1 ,
                    child: App.globalWidgets.expanded(
                      child: Consumer(
                          builder: (context,prov,_) {
                            return App.packageWidgets.condition(
                                duration: const Duration(milliseconds: 100) ,


                                condition: prov.watch(state.main.loadingProv).boolean ,


                                fallback: (_) {
                                  return const CircularProgressIndicator.adaptive();
                                } ,


                                builder: (context) {
                                  return App.buttons.elevated(
                                      size: const Size.fromHeight(double.infinity) ,
                                      borderRadius: BorderRadius.circular(15.0),
                                      onPressed: () async {
                                        await state.main.navigateToGoogleMap(context: context, userModel: userModel);
                                      },
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: App.text.translateText(
                                            LangEnum.yourLocation.name ,
                                            context ,
                                            fontSize: 20.0 ,
                                            fontWeight: FontWeight.bold ,
                                            color: App.color.helperWhite
                                        ),
                                      )
                                  );
                                }
                            );
                          }
                      ),
                    ),
                  ) ,


                  // Visibility(
                  //   visible: false ,
                  //   child: SizedBox(
                  //     height: keyBoard ? constraints.maxHeight * 0.1 : mediaQ.size.height * 0.1 ,
                  //     child: App.globalWidgets.expanded(
                  //       child: ListView.builder(
                  //           scrollDirection: Axis.horizontal ,
                  //           itemCount: state.main.dummyOrderData.length ,
                  //           itemBuilder: (BuildContext context, int i) {
                  //
                  //             return SizedBox(
                  //               width: mediaQ.size.width * 0.4,
                  //               child: Consumer(
                  //                 builder: (context,prov,_) {
                  //                   return ChoiceChip(
                  //                       label: App.text.text(
                  //                         state.main.dummyOrderData.elementAt(i)['name'], context ,
                  //                         fontSize: 20 ,
                  //                       ) ,
                  //                       checkmarkColor: App.color.helperWhite,
                  //                       labelStyle: TextStyle(color: App.color.helperWhite,fontSize: 20.0),
                  //                       onSelected: (v) {
                  //                         prov.read(state.main.paymentProv).equalValueInteger(i);
                  //
                  //                       },
                  //                       //color: MaterialStateProperty.all(Colors.white),
                  //                       selected: prov.watch(state.main.paymentProv).integer == i ? true : false
                  //                   );
                  //                 }
                  //               ),
                  //             );
                  //           }),
                  //     ),
                  //   ),
                  // ) ,

                  SizedBox(
                    height: keyBoard ? constraints.maxHeight * 0.1 : mediaQ.size.height * 0.1 ,
                    child: Consumer(
                      builder: (context, prov, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio.adaptive(
                                      value: '0',
                                      groupValue: prov.watch(state.main.paymentProv).integer.toString(),
                                      onChanged: (v) {
                                        prov.read(state.main.paymentProv).equalValueInteger(int.parse(v!));
                                      }
                                  ),
                                  App.text.text('Cash', context)
                                ],
                              ),
                            ) ,

                            Expanded(
                              child: Row(
                                children: [
                                  Radio.adaptive(
                                      value: '1',
                                      groupValue: prov.watch(state.main.paymentProv).integer.toString(),
                                      onChanged: (v) {
                                        prov.read(state.main.paymentProv).equalValueInteger(int.parse(v!));
                                      }
                                  ),
                                  App.text.text('Visa', context)
                                ],
                              ),
                            ) ,

                            Expanded(
                              child: Row(
                                children: [
                                  Radio.adaptive(
                                      value: "2",
                                      groupValue: prov.watch(state.main.paymentProv).integer.toString(),
                                      onChanged: (v) {
                                        prov.read(state.main.paymentProv).equalValueInteger(int.parse(v!));
                                      }
                                  ),
                                  App.text.text('Paypal', context)
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    ),
                  ) ,


                  SizedBox(
                    height: keyBoard ? constraints.maxHeight * 0.1 : mediaQ.size.height * 0.1 ,
                    child: App.globalWidgets.expanded(
                      child: Consumer(
                        builder: (context,prov,_) {
                          return App.packageWidgets.condition(
                            duration: const Duration(milliseconds: 100) ,


                            condition: prov.watch(state.main.loadingProv).boolean ,


                              fallback: (_) {
                                return const CircularProgressIndicator.adaptive();
                            } ,


                              builder: (context) {
                                return App.buttons.elevated(
                                  size: const Size.fromHeight(double.infinity) ,
                                    borderRadius: BorderRadius.circular(15.0),
                                    onPressed: () async {
                                    return state.main.payAndGetYourLocation(
                                        state: state,
                                        loadingProvider: state.main.loadingProv,
                                        context: context, ref: ref,
                                        amount: totalAndCountModel.totalPrice.toString(),
                                        userModel: userModel
                                    );
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: App.text.translateText(
                                          LangEnum.payAndLocation.name ,
                                          context ,
                                          fontSize: 20.0 ,
                                          fontWeight: FontWeight.bold ,
                                          color: App.color.helperWhite
                                      ),
                                    )
                                );
                            }
                          );
                        }
                      ),
                    ),
                  ) ,


                ],
              )
            );
          }
        ),
      ),
    );
  }
}



