import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Cart/init_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MobileCartPage extends StatelessWidget  {
  final InitCart state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final ThemeData theme;
  final bool isDark;
  final UserModel userModel;


  const MobileCartPage({
    Key? key ,
    required this.state ,
    required this.ref ,
    required this.keyBoard ,
    required this.connected ,
    required this.height ,
    required this.mediaQ ,
    required this.isDark ,
    required this.theme ,
    required this.userModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(ref.read(state.main.fetchTotalAndCountCartData()).dataList[0]);
    return Scaffold(

      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              return App.global.notificationListener(
                  notification: notification,
                  ref: ref,
                  providerListenable: state.main.changeScrollNotification
              );
            } ,
            child: Consumer(
              builder: (context,provScrollNotification,_) {
                return Consumer(
                    builder: (context,prov,_) {

                      return App.packageWidgets.condition(
                        duration: const Duration(milliseconds: 300),
                        condition: prov.watch(state.main.fetchCartData()).dataList.isEmpty ,
                        builder: (_) {
                          return const Center(
                            child:  Icon(Icons.remove_shopping_cart, size: 50.0),
                          );
                        },
                        fallback: (context) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await state.main.refresh(ref: ref, userModel: userModel);
                            },
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: (!provScrollNotification.watch(state.main.changeScrollNotification).boolean ?
                                  constraints.maxHeight * 0.75 : constraints.maxHeight),
                                  child: ListView.builder(

                                      itemCount: prov.watch(state.main.fetchCartData()).dataList.length,

                                      controller: state.main.scrollCartController ,

                                      itemBuilder: (BuildContext context, int i) {

                                        final BaseCartModel model =
                                        CartModel.fromJson(prov
                                            .read(state.main.fetchCartData())
                                            .dataList
                                            .elementAt(i)
                                        );


                                        return GestureDetector(

                                          onTap: () async {

                                            await state.main.navigateToDetailsScreen(
                                                context: context ,
                                                userModel: userModel ,
                                                cartModel: model ,
                                                index: i ,
                                                state: state,
                                                ref: ref
                                            );

                                          },

                                          child: Dismissible(

                                            key: ValueKey<String>(model.id) ,

                                            onDismissed: (v) async {
                                              return await state.main.deleteOnlyCart(
                                                  userModel: userModel ,
                                                  productId: model.id ,
                                                  ref: ref ,
                                                  context: context ,
                                                  index: i
                                              );
                                            } ,

                                            child: Container(
                                              width: double.infinity ,

                                              height: constraints.maxHeight * 0.2 ,

                                              padding: const EdgeInsets.all(1.0) ,

                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: App.theme.conditionTheme(
                                                    context: context,
                                                    light: App.color.helperWhite,
                                                    dark: App.color.darkFirst
                                                ),
                                              ) ,

                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 20.0 ,
                                                  vertical: 10.0
                                              ) ,

                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(7.0),
                                                        child: SizedBox(
                                                          height: double.infinity,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                            child: Image.network(
                                                              '${App.strings.mainUrl}/${model.image}' ,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ) ,


                                                  Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [

                                                            FittedBox(
                                                              fit: BoxFit.scaleDown,
                                                              child: App.text.text(
                                                                  model.name, context ,
                                                                fontSize: 24.0 ,
                                                                fontWeight: FontWeight.bold
                                                              ),
                                                            ) ,


                                                            Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  FittedBox(
                                                                    fit: BoxFit.scaleDown,
                                                                    child: App.text.translateText(
                                                                        LangEnum.price.name, context ,
                                                                      fontSize: 17.0 ,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),

                                                                  FittedBox(
                                                                    fit: BoxFit.scaleDown,
                                                                    child: App.text.text(
                                                                        '${model.total}\$', context ,
                                                                      fontSize: 17.0 ,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ) ,


                                                            Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [

                                                                  Expanded(
                                                                      child: CircleAvatar(
                                                                        radius: 15.0,
                                                                        backgroundColor: App.theme.conditionTheme(
                                                                            context: context,
                                                                            light: App.color.lightMain ,
                                                                            dark: App.color.darkMain
                                                                        ),
                                                                        child: App.buttons.icon(
                                                                            onPressed: () async {
                                                                              /// To prevent data display if it equal Zero
                                                                              if(ref.read(state.main.fetchCartData()).dataList.elementAt(i)['quantity'] == 1) {
                                                                                return;
                                                                              } else {
                                                                                await state.main.removeFromCart(
                                                                                    userModel: userModel ,
                                                                                    model: model ,
                                                                                    ref: ref ,
                                                                                    index: i
                                                                                );
                                                                              }

                                                                            } ,
                                                                            icon: Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  bottom: 15.0
                                                                              ),
                                                                              child: Icon(
                                                                                Icons.minimize_sharp ,
                                                                                color: App.color.helperWhite ,
                                                                                size: 12.0,
                                                                              ),
                                                                            )
                                                                        ),
                                                                      )
                                                                  ) ,


                                                                  Expanded(
                                                                      child: Container(
                                                                          margin: const EdgeInsets.only(bottom: 5.0),
                                                                          alignment: Alignment.bottomCenter,
                                                                          child: App.text.text(
                                                                            model.quantity.toString() , context ,
                                                                            fontSize: 14.0 ,
                                                                          )
                                                                      )
                                                                  ) ,


                                                                  Expanded(
                                                                      child: CircleAvatar(
                                                                        radius: 15.0,
                                                                        backgroundColor: App.theme.conditionTheme(
                                                                            context: context,
                                                                            light: App.color.lightMain ,
                                                                            dark: App.color.darkMain
                                                                        ),
                                                                        child: App.buttons.icon(
                                                                            onPressed: () async {
                                                                           await state.main.addToCart(
                                                                                  userModel: userModel ,
                                                                                  model: model ,
                                                                                  ref: ref,
                                                                                  index: i ,
                                                                                  context: context
                                                                              );
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.add ,
                                                                              color: App.color.helperWhite,
                                                                              size: 12.0,
                                                                            )
                                                                        ),
                                                                      )
                                                                  )

                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )

                                          ),
                                        );
                                      }),
                                ) ,


                                AnimatedContainer(
                                  curve: Curves.ease ,
                                  height: (!provScrollNotification.watch(state.main.changeScrollNotification).boolean ?
                                  constraints.maxHeight * 0.25 : 0.0),
                                  width: double.infinity,
                                  color: App.theme.conditionTheme(
                                      context: context ,
                                      light: App.color.helperWhite ,
                                      dark: App.color.darkFirst
                                  ),

                                  duration: const Duration(milliseconds: 500) ,

                                  child: Consumer(
                                      builder: (context,prov,_) {
                                        late  TotalAndCountModel model;

                                        if(prov.watch(state.main.fetchTotalAndCountCartData()).dataList.isNotEmpty) {
                                          model = TotalAndCountModel.fromJson(
                                              prov.watch(state.main.fetchTotalAndCountCartData()).dataList.elementAt(0)
                                          );
                                        } else {
                                          model = const TotalAndCountModel(totalCount: 0, totalPrice: 0);
                                        }



                                        return Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                                children: [
                                                  FittedBox(
                                                      fit: BoxFit.scaleDown ,
                                                      child: App.text.translateText(
                                                          LangEnum.total.name, context ,
                                                          fontSize: 20.0 ,
                                                          fontWeight: FontWeight.bold
                                                      )
                                                  ) ,

                                                  FittedBox(
                                                      fit: BoxFit.scaleDown ,
                                                      child: App.text.text(
                                                          model.totalPrice.toString() , context ,
                                                          fontSize: 20.0 ,
                                                          fontWeight: FontWeight.bold
                                                      )
                                                  ) ,
                                                ],
                                              ),
                                            ) ,

                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                                children: [
                                                  FittedBox(
                                                      fit: BoxFit.scaleDown ,
                                                      child: App.text.translateText(
                                                          LangEnum.totalCount.name, context ,
                                                          fontSize: 20.0 ,
                                                          fontWeight: FontWeight.bold
                                                      )
                                                  ) ,

                                                  FittedBox(
                                                      fit: BoxFit.scaleDown ,
                                                      child: App.text.text(
                                                          model.totalCount.toString(), context ,
                                                          fontSize: 20.0 ,
                                                          fontWeight: FontWeight.bold
                                                      )
                                                  ) ,
                                                ],
                                              ),
                                            ) ,

                                            Expanded(
                                              child: App.globalWidgets.expanded(
                                                child: App.buttons.elevated(
                                                    onPressed: () async {

                                                      await state.main.navigateToOrderScreen(
                                                          model: model ,
                                                          userModel: userModel ,
                                                          context: context
                                                      );
                                                    },
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: App.text.translateText(
                                                        LangEnum.checkOut.name, context ,
                                                        fontSize: 20.0 ,
                                                        fontWeight: FontWeight.bold ,
                                                        color: App.color.helperWhite
                                                    )
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      );
                    }
                );
              }
            ),
          );
        }
      ),
    );
  }
}
