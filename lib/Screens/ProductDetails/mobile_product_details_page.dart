import 'package:commerce/App/app.dart';
import 'package:commerce/Model/product_details_model.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/ProductDetails/init_product_details.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MobileProductDetailsPage extends StatelessWidget  {
  final InitProductDetails state;
  final InitProducts productState;
  final WidgetRef ref;
  final UserModel userModel;
  final int index;
  final BaseProductModel productModel;
  final BaseProductDetailsModel model;


  const MobileProductDetailsPage({Key? key ,
    required this.state, required this.productState,
    required this.ref, required this.userModel,
    required this.index, required this.model,
    required this.productModel
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

                                              await state.main.decreaseCart(
                                                  ref: ref ,
                                                  productModel: productModel ,
                                                  userModel: userModel ,
                                                  context: context ,
                                                  model: model
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
                                              await state.main.addToCart(
                                                  ref: ref ,
                                                  productModel: productModel ,
                                                  userModel: userModel ,
                                                  context: context
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
                              model.createdAt.substring(0, 10), context ,
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


            const Spacer(flex: 2) ,


            state.mobile.buildAddToCart(
                state: state ,
                ref: ref ,
                productState: productState ,
                userModel: userModel ,
                model: model ,
                context: context,
                productModel: productModel
            ),


            const Spacer()

          ],
        )
    );
  }




}
