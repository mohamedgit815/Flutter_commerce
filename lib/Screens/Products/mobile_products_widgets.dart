import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/category_controller.dart';
import 'package:commerce/Model/category_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:commerce/Screens/Products/products_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseMobileProductsWidgets {
  Widget buildTitleAndSearch({
    required BuildContext context ,
    required InitProducts state
  });


  Widget selectedProducts({
    required InitProducts state ,
    required BoxConstraints constraints ,
    required WidgetRef selectedProv ,
  });

  Widget buildProducts({
    required InitProducts state ,
    required BoxConstraints constraints ,
    required UserModel userModel ,
    required WidgetRef selectedProv ,
  });
}







class MobileProductsWidgets implements BaseMobileProductsWidgets {
  @override
  Widget buildTitleAndSearch({
    required BuildContext context ,
    required InitProducts state
  }) {
    return App.globalWidgets.expanded(
      child: Column(
        children: [
          const Spacer() ,

          Expanded(
            flex: 7,
            child: App.text.translateText(
                LangEnum.bestProduct.name, context ,
                fontSize: 45.0 , fontWeight: FontWeight.bold ,
                maxLine: 9
            ),
          ) ,

          const Spacer(flex: 1) ,

          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () async {
                await showSearch(context: context, delegate: ProductSearchScreen() );
              },
              child: TextField(
                  enabled: false ,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search) ,
                    hintText: "${App.localization.translate(context: context, text: LangEnum.search.name)}" ,
                  ) ,


                ),
            ),

          ) ,

          const Spacer(flex: 1,) ,
        ],
      ),
    );
  }




  @override
  Widget selectedProducts({
    required InitProducts state ,
    required BoxConstraints constraints ,
    required WidgetRef selectedProv ,
  }) {
    return Column(
      children: [

        Expanded(
          flex: 3 ,
          child: Consumer(
              builder: (context,prov,_) {
                return prov
                    .watch(BaseCategoryController.categoryProv)
                    .when(
                    error: (err,stack) => Center(child: App.text.text(err.toString(),context,fontSize: 20.0)) ,
                    loading: () {
                      return App.globalWidgets.expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal ,
                            itemCount: 7,
                            itemBuilder: (context,i){
                              return App.packageWidgets.shimmer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Center(
                                    child: App.text.translateText(
                                      LangEnum.loading.name, context ,
                                      fontSize: 20.0 ,
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      );
                    },

                    data: (data) {


                      return App.globalWidgets.expanded(
                          child: ListView.builder(

                              scrollDirection: Axis.horizontal ,

                              itemCount: data.length ,

                              itemBuilder: (context, int selectedIndex) {
                                final BaseCategoryModel model = CategoryModel.fromJson(data.elementAt(selectedIndex));
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0) ,
                                  child: InkResponse(
                                    onTap: () {
                                      selectedProv.read(state.main.selectedProv).equalValueInteger(selectedIndex);
                                    },
                                    child: Center(
                                      child: App.text.translateText(
                                          model.name, context ,
                                          fontSize: 20.0 ,
                                          color: App.theme.conditionTheme(
                                              context: context,
                                              light: selectedProv.watch(state.main.selectedProv).integer != selectedIndex ? App.color.helperGrey600: App.color.lightMain,
                                              dark: selectedProv.read(state.main.selectedProv).integer != selectedIndex ? App.color.helperWhite: App.color.darkMain
                                          )
                                      ),
                                    ),
                                  )
                                );
                              }

                          )
                      );
                    }
                );

              }
          ),
        ) ,

        const Spacer(flex: 2) ,
      ],
    );
  }



  @override
  Widget buildProducts({
    required InitProducts state ,
    required BoxConstraints constraints ,
    required UserModel userModel ,
    required WidgetRef selectedProv ,
  }) {
    return Expanded(
        flex: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Consumer(
              builder: (context, prov, _) {
                return AnimatedConditionalBuilder(
                  condition: selectedProv.watch(state.main.selectedProv).integer == 1  ,


                  builder: (context) {
                    return App.globalWidgets.fetchProductDataByCategory(
                      state: state,
                      provider: prov ,
                      constraints: constraints,
                      listenable: state.mainFashion.fetchData ,
                      scrollController: state.mainFashion.scrollController ,
                      pageStorageKey: StorageKeyEnum.fashion.name,
                      userModel: userModel
                    );
                  },


                  fallback:  (context) {
                    return AnimatedConditionalBuilder(
                        condition: selectedProv.watch(state.main.selectedProv).integer == 2,

                        builder: (_) {
                          return App.globalWidgets.fetchProductDataByCategory(
                            state: state,
                            provider: prov ,
                            constraints: constraints,
                            listenable: state.mainTech.fetchData ,
                            scrollController: state.mainTech.scrollController ,
                            pageStorageKey: StorageKeyEnum.tech.name ,
                            userModel: userModel
                          );
                        } ,


                        fallback: (_) {

                          return AnimatedConditionalBuilder(
                              condition: selectedProv.watch(state.main.selectedProv).integer == 3 ,


                              builder: (_) {
                                return App.globalWidgets.fetchProductDataByCategory(
                                  state: state,
                                  provider: prov ,
                                  constraints: constraints,
                                  listenable: state.mainHealth.fetchData ,
                                  scrollController: state.mainHealth.scrollController ,
                                  pageStorageKey: StorageKeyEnum.health.name ,
                                  userModel: userModel
                                );
                              },


                              fallback: (_) {
                                return App.globalWidgets.fetchProductDataByCategory(
                                  state: state,
                                  provider: prov ,
                                  constraints: constraints,
                                  listenable: state.mainAllProduct.fetchData ,
                                  scrollController: state.mainAllProduct.scrollController ,
                                  pageStorageKey: StorageKeyEnum.allProduct.name,
                                  userModel: userModel
                                );
                              }
                          );

                        }
                    );
                  },
                );
              }
          ),
        )
    );
  }
}