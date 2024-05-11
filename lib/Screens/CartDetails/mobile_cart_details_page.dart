import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Cart/init_cart.dart';
import 'package:commerce/Screens/CartDetails/init_cart_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MobileCartDetailsPage extends StatelessWidget  {
  final InitCartDetails state;
  final InitCart cartState;
  final WidgetRef ref;
  final UserModel userModel;
  final int index;
  final BaseCartModel model ,  cartModel;
  final TotalAndCountModel totalAndCountModel;

  const MobileCartDetailsPage({
    Key? key ,
    required this.userModel ,
    required this.state ,
    required this.ref ,
    required this.index ,
    required this.cartState,
    required this.model ,
    required this.cartModel ,
    required this.totalAndCountModel
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: const BackButton(),
      ),

      body: Column(
        children: [

          Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0) ,
                child: Image.network(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: double.infinity ,
                    fit: BoxFit.fill ,
                    "${App.strings.mainUrl}/${model.image}"
                ),
              )
          ) ,


          Expanded(
            flex: 4,
            child: Column(
              children: [
                const Spacer(flex: 2) ,

                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft ,
                        child: App.text.text(
                            model.name, context ,
                            fontSize: 30.0
                        ),
                      ),
                    )
                ) ,

                const Spacer(flex: 1) ,

                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: App.theme.conditionTheme(
                                      context: context ,
                                      light: App.color.helperBlack ,
                                      dark: App.color.helperGrey600
                                  ) ,
                                  width: 0.5
                              ) ,
                              borderRadius: BorderRadius.circular(20.0) ,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround ,
                              children: [

                                Expanded(
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown ,
                                      child: IconButton(
                                          onPressed: () async {
                                            /// To prevent data display if it equal Zero

                                            return await state.main.removeFromCart(
                                                cartState: cartState,
                                                state: state,
                                                userModel: userModel,
                                                ref: ref,
                                                context: context,
                                                cartModel: cartModel,
                                                index: index
                                            );

                                          },
                                          icon: Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0) ,
                                            child: Icon(Icons.minimize_sharp,size: 30,
                                              color: App.theme.conditionTheme(
                                                  context: context,
                                                  light: App.color.helperBlack,
                                                  dark: App.color.helperWhite
                                              ),
                                            ) ,
                                          )
                                      )
                                  ),
                                ),

                                Expanded(
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown ,
                                      child: App.text.text(model.quantity.toString(), context,fontSize: 20)
                                  ),
                                ) ,

                                Expanded(
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown ,
                                      child: IconButton(
                                          onPressed: () async {
                                            return await state.main.addToCart(
                                                state: state ,
                                                userModel: userModel ,
                                                ref: ref ,
                                                context: context ,
                                                cartModel: cartModel ,
                                                index: index ,
                                                cartState: cartState
                                            );
                                          },
                                          icon: Icon(
                                            Icons.add ,
                                            size: 30.0 ,
                                            color: App.theme.conditionTheme(
                                                context: context ,
                                                light: App.color.helperBlack ,
                                                dark: App.color.helperWhite
                                            ),
                                          )
                                      )
                                  ),
                                )

                              ],
                            ),
                          ),
                        ) ,

                        const Spacer() ,

                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: App.text.text(
                                  "\$ ${model.total.toDouble()}", context ,
                                  fontSize: 24.0
                              ),
                            ),
                          ),
                        ) ,
                      ],
                    )
                ) ,

                const Spacer(flex: 1) ,

                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft ,
                        child: App.text.text(
                            model.createdAt.substring(0,10,), context ,
                            fontSize: 15.0 ,
                            color: App.theme.conditionTheme(
                                context: context ,
                                light: App.color.grey.shade900,
                                dark: App.color.grey.shade400
                            )
                        ),
                      ),
                    )
                ) ,

                const Spacer(flex: 2)
              ],
            ),
          ) ,


          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: App.text.translateText(
                              LangEnum.totalCount.name,
                              context , fontSize: 20.0
                          ),
                        ),
                      ) ,

                      const Spacer() ,

                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: App.text.text(
                                "${totalAndCountModel.totalCount}", context ,
                                fontSize: 24.0
                            ),
                          ),
                        ),
                      ) ,
                    ],
                  ) ,
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: App.text.translateText(
                              LangEnum.total.name,
                              context , fontSize: 20.0
                          ),
                        ),
                      ) ,

                      const Spacer() ,

                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: App.text.text(
                                "\$ ${totalAndCountModel.totalPrice.toDouble()}", context ,
                                fontSize: 24.0
                            ),
                          ),
                        ),
                      ) ,



                    ],
                  ) ,
                ],
              )
          ) ,


          Expanded(
            child: App.globalWidgets.expanded(
              child: App.buttons.elevated(
                  onPressed: () async {
                    await cartState.main.navigateToOrderScreen(
                        model: totalAndCountModel ,
                        userModel: userModel ,
                        context: context
                    );
                  },
                  borderRadius: BorderRadius.circular(15.0),
                  size: const Size(double.infinity, double.infinity),
                  child: App.text.translateText(LangEnum.checkOut.name , context,
                      fontSize: 20.0 ,
                      color: App.color.helperWhite
                  )
              ),
            ),
          ) ,


          const Spacer()

        ],
      )
    );
  }
}
