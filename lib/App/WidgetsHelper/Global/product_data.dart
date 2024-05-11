import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:commerce/Screens/Products/main_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchProductDataByCategory extends StatelessWidget {
  final InitProducts state;
  final WidgetRef prov;
  final ProviderListenable<FetchDataProvider> listenable;
  final BoxConstraints constraints;
  final String pageStorageKey;
  final ScrollController scrollController;
  final UserModel userModel;


  const FetchProductDataByCategory({
    super.key ,
    required this.state ,
    required this.prov ,
    required this.constraints ,
    required this.listenable ,
    required this.pageStorageKey ,
    required this.scrollController ,
    required this.userModel
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedConditionalBuilder(
      duration:  const Duration(milliseconds: 300),

      condition: prov.watch(listenable).dataList.isEmpty ,

      builder: (context) {
        return ListView.builder(
            scrollDirection: Axis.horizontal ,
            itemCount: 9 ,
            controller: scrollController ,
            key: PageStorageKey<String>(pageStorageKey) ,
            itemBuilder: (BuildContext context, int i) {
              return App.packageWidgets.shimmer(
                  child: Container(
                    width: constraints.maxWidth * 0.5 ,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: App.theme.conditionTheme(
                          context: context,
                          light: App.color.helperGrey200 ,
                          dark: App.color.darkForty
                      ) ,
                      borderRadius: BorderRadius.circular(10.0) ,
                    ),
                  )
              );
            }
        );
      } ,


      fallback: (context) {
        return ListView.builder(
            scrollDirection: Axis.horizontal ,
            itemCount: prov.watch(listenable).dataList.length ,
            controller: scrollController ,
            key: PageStorageKey<String>(pageStorageKey) ,

            itemBuilder: (BuildContext context, int i) {
              final FetchDataProvider provider = prov.read(listenable);
              final BaseProductModel model = ProductModel.fromJson(provider.dataList.elementAt(i));

              return GestureDetector(
                onTap: () async {
                  /// To Send Data throw Argument by Dart Records

                  await state.main.navigateToDetailsScreen(
                      context: context ,
                      userModel: userModel ,
                      productModel: model ,
                      index: i,
                      state: state
                  );
                },
                child: Container(
                  width: constraints.maxWidth * 0.5 ,
                  margin: const EdgeInsets.symmetric(horizontal: 15.0) ,
                  decoration: BoxDecoration(
                    color: App.theme.conditionTheme(
                        context: context,
                        light: App.color.helperGrey200 ,
                        dark: App.color.darkFirst
                    ) ,
                    borderRadius: BorderRadius.circular(10.0) ,
                  ),
                  child: Column(
                    children: [

                      Expanded(
                          flex: 6,
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0) ,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("${App.strings.mainUrl}/${model.image}")
                                )
                            ),
                          )
                      ) ,


                      Expanded(
                          flex: 3 ,
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [


                                        Expanded(
                                          child: App.text.text(
                                              model.name, context,
                                              fontSize: 18.0 ,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ) ,


                                        Expanded(
                                          child: App.text.text(
                                              model.content, context ,
                                              color: Colors.grey.shade600 ,
                                              fontSize: 14.0
                                          ),
                                        ) ,


                                      ],
                                    ),
                                  ),
                                ),
                              ) ,


                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Flexible(
                                        child: App.text.text(
                                            "\$${model.price}", context ,
                                            fontSize: 17.0 ,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ) ,


                                      Flexible(
                                        child: Consumer(
                                          builder: (context,prov,_) {
                                            return InkResponse(
                                              onTap: () async {
                                                  await state.main.addToCart(
                                                      context: context ,
                                                      ref: prov ,
                                                      model: model ,
                                                      userModel: userModel ,
                                                      state: state
                                                  );
                                              } ,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: App.theme.conditionTheme(
                                                          context: context,
                                                          light: App.color.lightMain,
                                                          dark: App.color.darkMain
                                                      ) ,
                                                      borderRadius: BorderRadius.circular(5.0)
                                                  ),
                                                  child: const Icon(
                                                      Icons.add ,
                                                      size: 25.0 ,
                                                      color: Colors.white
                                                  )
                                              ),
                                            );
                                          }
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )
                      ) ,


                      const Spacer()


                    ],
                  ),
                ),
              );
            });
      }
    );
  }
}
