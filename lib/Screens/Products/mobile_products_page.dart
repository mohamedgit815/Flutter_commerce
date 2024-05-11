import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileProductsPage extends StatelessWidget  {
  final InitProducts state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final UserModel userModel;


  const MobileProductsPage({
    Key? key ,
    required this.state ,
    required this.ref ,
    required this.keyBoard ,
    required this.connected ,
    required this.height ,
    required this.mediaQ ,
    required this.userModel
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        //backgroundColor: App.color.darkSecond ,

        elevation: 0 ,

        leading: DrawerButton(onPressed: () {
          Scaffold.of(context).openDrawer();
        },) ,
      ) ,




      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return RefreshIndicator(



            onRefresh: () async {

              final int index = ref.read(state.main.selectedProv).integer;

              if(index == 1) {
                return await state
                    .mainFashion
                    .refresh(
                    ref: ref
                );
              } else if(index == 2 ) {
                return await state
                    .mainTech
                    .refresh(
                    ref: ref
                );
              } else if(index == 3) {
                return await state
                    .mainHealth
                    .refresh(
                    ref: ref
                );
              } else {
                return await state
                    .mainAllProduct
                    .refresh(
                    ref: ref
                );
              }

            } ,



            child: ListView(
              children: [


                SizedBox(
                  height: constraints.maxHeight ,
                  child: Column(
                    children: [

                      /// Title and Search
                      Expanded(
                        flex: 6,
                        child: state.mobile.buildTitleAndSearch(context: context,state: state)
                      ) ,


                      /// Category and Products
                      Expanded(
                        flex: 8 ,
                        child: Consumer(
                          builder: (context, selectedProv, _) {
                            return Column(
                              children: [

                                /// Category
                                Expanded(
                                  flex: 1,
                                  child: state.mobile.selectedProducts(
                                      state: state ,
                                      constraints: constraints,
                                      selectedProv: selectedProv
                                  ),
                                ) ,




                                /// Products
                                state.mobile.buildProducts(
                                    state: state,
                                    constraints: constraints,
                                    userModel: userModel,
                                    selectedProv: selectedProv,
                                )


                              ],
                            );
                          }
                        ),
                      ) ,

                      
                      const Spacer(),


                    ],
                  ),
                )


              ],
            ),
          );
        }
      ),
    );
  }
}
