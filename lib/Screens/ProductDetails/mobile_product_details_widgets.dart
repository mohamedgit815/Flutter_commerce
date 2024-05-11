import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/product_details_model.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/ProductDetails/init_product_details.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseMobileProductDetailsWidgets {
  Widget buildAddToCart({
    required InitProductDetails state,
    required InitProducts productState,
    required WidgetRef ref ,
    required UserModel userModel ,
    required BuildContext context ,
    required BaseProductDetailsModel model ,
    required BaseProductModel productModel ,
  });
}

class MobileProductDetailsWidgets implements BaseMobileProductDetailsWidgets {


  @override
  Widget buildAddToCart({
    required InitProductDetails state,
    required InitProducts productState,
    required WidgetRef ref ,
    required UserModel userModel ,
    required BuildContext context ,
    required BaseProductDetailsModel model ,
    required BaseProductModel productModel ,
  }) {
    return Expanded(
      child: App.globalWidgets.expanded(
        child: App.buttons.elevated(
            onPressed: () async {

              if(!ref.read(state.main.fetchProductDetailsProv).dataList.elementAt(0)) {
                await state.main.addToCart(
                    ref: ref,
                    productModel: productModel,
                    userModel: userModel,
                    context: context
                );
              } else {

                if(context.mounted) {
                  await state.main.deleteFromCart(
                      ref: ref,
                      productModel: productModel,
                      userModel: userModel,
                      context: context,
                      model: model
                  );
                }
              }

            },

            borderRadius: BorderRadius.circular(15.0),
            size: const Size(double.infinity, double.infinity),
            child: Consumer(
                builder: (context, prov, _) {
                  return App.packageWidgets.condition(
                    duration: const Duration(milliseconds: 200) ,
                    condition: model.isProductExist ,

                    builder: (context) {
                      return App.text.translateText(
                          LangEnum.removeCart.name ,
                          context,
                          fontSize: 20.0 ,
                          color: App.color.helperWhite
                      );
                    } ,




                    fallback: (context) {
                      return App.text.translateText(
                          LangEnum.addToCart.name ,
                          context ,
                          fontSize: 20.0 ,
                          color: App.color.helperWhite

                      );} ,
                  );
                }
            )
        ),
      ),
    );
  }
}