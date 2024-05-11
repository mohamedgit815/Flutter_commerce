 import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/orders_model.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Orders/init_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileOrdersPage extends StatelessWidget  {
  final InitOrders state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final ThemeData theme;
  final bool isDark;
  final UserModel userModel;

  const MobileOrdersPage({
    Key? key ,
    required this.state ,
    required this.ref ,
    required this.keyBoard ,
    required this.connected ,
    required this.height ,
    required this.mediaQ ,
    required this.isDark ,
    required this.theme ,
    required this.userModel ,
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
        title: App.text.translateText(LangEnum.order.name, context,fontSize: 20.0),
        elevation: 0 ,
      ),

      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [

                SizedBox(
                  height: keyBoard ? constraints.maxHeight : mediaQ.size.height ,
                  child: Consumer(
                    builder: (context, prov, _) {
                      final provider = prov.watch(state.main.fetchOrderData());
                      return App.packageWidgets.condition(
                        duration: const Duration(milliseconds: 500),

                        condition: provider.dataList.isNotEmpty  ,


                        builder: (context) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await state.main.refresh(ref: ref, userModel: userModel);
                            },
                            child: ListView.builder(
                                itemCount: provider.dataList.length ,
                                controller: state.main.scrollController ,
                                //key: const PageStorageKey("OrdersPage"),
                                itemBuilder: (context,i) {

                                final BaseOrdersModel model =
                                OrdersModel.fromJson(prov
                                    .read(state.main.fetchOrderData())
                                    .dataList
                                    .elementAt(i)
                                );


                                return Container(
                                width: double.infinity,
                                height: constraints.maxHeight * 0.15,
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: App.color.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15.0)
                                ),
                                child: Stack(
                                  children: [



                                    InkWell(
                                      onTap: () async {
                                        await state.main.navigateToGoogleMap(
                                            context: context ,
                                            ordersModel: model ,
                                            userModel: userModel
                                        );
                                      },
                                      child: Row(
                                        children: [


                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                App.text.translateText(LangEnum.total.name, context,fontSize: 20.0) ,
                                                App.text.text(': ${model.total}', context,fontSize: 20.0) ,
                                              ],
                                            ),
                                          ) ,

                                          Expanded(
                                              child: Center(
                                                child: App.text.text(
                                                model.status, context ,
                                                fontSize: 20.0 ,
                                                color: Colors.deepOrange
                                                ),
                                              )) ,
                                        ],
                                      ),
                                    ),

                                    const Visibility(
                                        visible: false ,
                                        child:  Center(child: Divider(color: Colors.black,))) ,
                                  ],
                                ),
                                                              );
                            }),
                          );
                        } ,



                        fallback: (context) {
                          return ListView.builder(
                              itemCount: 15,
                              itemBuilder: (context,i) {
                              return App.packageWidgets.shimmer(
                                child: Container(
                                width: double.infinity,
                                height: constraints.maxHeight * 0.15,
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: App.color.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15.0)
                                ),
                                child:  Row(
                                  children: [


                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          App.text.translateText(
                                              LangEnum.loading.name, context ,
                                              fontSize: 20.0 ,
                                              color: Colors.deepOrange
                                          ),
                                        ],
                                      ),
                                    ) ,

                                    Expanded(
                                        child: Center(
                                          child: App.text.translateText(
                                              LangEnum.loading.name, context ,
                                              fontSize: 20.0 ,
                                              color: Colors.deepOrange
                                          ),
                                        )) ,
                                  ],
                                ),
                                                                ),
                              );
                          });
                        }
                      );
                    }
                  ),
                )

              ],
            )
          );
        }
      ),
    );
  }
}



