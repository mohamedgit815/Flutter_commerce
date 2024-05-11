import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/product_details_model.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseProductDetailsState {
  final fetchProductDetailsProv = ChangeNotifierProvider((ref) => FetchDataProvider());

  ProviderListenable<FetchDataProvider> fetchCartData();

  ProviderListenable<FetchDataProvider> fetchTotalAndCountCartData();

  Future<void> fetchProductDetails({
    required WidgetRef ref ,
    required BaseProductModel model ,
    required UserModel userModel ,
    required int quantity,
    required int total,
    required bool productExist ,
  });

  BaseProductDetailsModel getProductDetails({
    required WidgetRef refProv
  });


  Future<void> addToCart({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required UserModel userModel ,
    required BuildContext context ,
  });


  Future<void> decreaseCart({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required UserModel userModel ,
    required BuildContext context ,
    required BaseProductDetailsModel model ,
  });


  Future<void> deleteFromCart({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required BaseProductDetailsModel model ,
    required UserModel userModel ,
    required BuildContext context
  });

}



class ProductDetailsState extends BaseProductDetailsState {
  @override
  ProviderListenable<FetchDataProvider> fetchCartData() {
    return Controller.cart.fetchCartData;
  }


  @override
  Future<void> fetchProductDetails({
    required WidgetRef ref ,
    required BaseProductModel model ,
    required UserModel userModel ,
    required int quantity,
    required int total,
    required productExist ,
  }) async {
    await ref.read(fetchProductDetailsProv).add(value: productExist);
    await ref.read(fetchProductDetailsProv).add(value: model.id);
    await ref.read(fetchProductDetailsProv).add(value: model.content);
    await ref.read(fetchProductDetailsProv).add(value: model.name);
    await ref.read(fetchProductDetailsProv).add(value: model.image);
    await ref.read(fetchProductDetailsProv).add(value: model.category);
    await ref.read(fetchProductDetailsProv).add(value: model.createdAt);
    await ref.read(fetchProductDetailsProv).add(value: model.updatedAt);
    await ref.read(fetchProductDetailsProv).add(value: model.price);
    await ref.read(fetchProductDetailsProv).add(value: quantity);
    await ref.read(fetchProductDetailsProv).add(value: total);
  }



  @override
  ProviderListenable<FetchDataProvider> fetchTotalAndCountCartData() {
    return Controller.cart.fetchTotalAndCountCartData;
  }


  @override
  BaseProductDetailsModel getProductDetails({
    required WidgetRef refProv
  }) {
    final List data = refProv.watch(fetchProductDetailsProv).dataList;


    late final BaseProductDetailsModel productModel;

    if(data.isEmpty) {

      productModel = const ProductDetailsModel(
          id: "" ,
          content: "" ,
          name: "" ,
          image: "" ,
          category: "" ,
          createdAt: "" ,
          updatedAt: "" ,
          price: 0 ,
          quantity: 1,
          total: 0 ,
          isProductExist: false
      ) ;

    } else {

      productModel = ProductDetailsModel(
          isProductExist: data.elementAt(0),
          id: data.elementAt(1),
          content: data.elementAt(2),
          name: data.elementAt(3),
          image: data.elementAt(4),
          category: data.elementAt(5),
          createdAt: data.elementAt(6),
          updatedAt: data.elementAt(7),
          price: data.elementAt(8),
          quantity: data.elementAt(9),
          total: data.elementAt(10),
      );

    }

    return productModel;
  }


  @override
  Future<void> addToCart({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required UserModel userModel ,
    required BuildContext context ,
  }) async {
    return await Controller.cart.addToCart(
        userModel: userModel,
        productId: productModel.id ,
        ref: ref,
        context: context,
        providerCart: fetchCartData()
    ).then((Response value) async {
      final Map<String,dynamic> data = await value.data['data'];

      if(value.statusCode == 201) {
        /// Functions Add Product Item
        ref.read(fetchCartData()).add(value: data);
        ref.read(fetchProductDetailsProv).changeBoolValue();
        ref.read(fetchTotalAndCountCartData()).updateInteger(
            index: 0 ,
            plus: true ,
            updateKey: 'count'
        );


        /// This Function are executed in State 200&201
        _getTotalPriceOfProductAndIncreaseCount(ref: ref);

        if(context.mounted) {
          App.alertWidgets.snackBar(text: LangEnum.cartAdded.name, context: context);
        }


      } else if(value.statusCode == 200) {

        _increaseTotalAndQuantityForDetailsScreen(ref: ref, response: value);

        _increaseTotalAndQuantityForProductScreen(
            ref: ref ,
            response: value ,
            productModel: productModel
        );

        /// This Function are executed in State 200&201
        _getTotalPriceOfProductAndIncreaseCount(ref: ref);
      }
    });
  }

  Future<void> addToCart201({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required UserModel userModel ,
    required BuildContext context ,
  }) async {
    return await Controller.cart.addToCart(
        userModel: userModel,
        productId: productModel.id ,
        ref: ref,
        context: context,
        providerCart: fetchCartData()
    ).then((Response value) async {
      final Map<String,dynamic> data = await value.data['data'];

      if(value.statusCode == 201) {
        /// Functions Add Product Item
        ref.read(fetchCartData()).add(value: data);
        ref.read(fetchProductDetailsProv).changeBoolValue();
        ref.read(fetchTotalAndCountCartData()).updateInteger(
            index: 0 ,
            plus: true ,
            updateKey: 'count'
        );


        /// This Function are executed in State 200&201
        _getTotalPriceOfProductAndIncreaseCount(ref: ref);

        if(context.mounted) {
          App.alertWidgets.snackBar(text: LangEnum.cartAdded.name, context: context);
        }

      }
    });
  }

  Future<void> addToCart200({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required UserModel userModel ,
    required BuildContext context ,
  }) async {
    return await Controller.cart.addToCart(
        userModel: userModel,
        productId: productModel.id ,
        ref: ref,
        context: context,
        providerCart: fetchCartData()
    ).then((Response value) async {

      if(value.statusCode == 200) {

        _increaseTotalAndQuantityForDetailsScreen(ref: ref, response: value);

        _increaseTotalAndQuantityForProductScreen(
            ref: ref ,
            response: value ,
            productModel: productModel
        );

        /// This Function are executed in State 200&201
        _getTotalPriceOfProductAndIncreaseCount(ref: ref);
      }
    });
  }



  @override
  Future<void> decreaseCart({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required UserModel userModel ,
    required BuildContext context ,
    required BaseProductDetailsModel model ,
  }) async {
    if(model.quantity <= 1) {
      return;
    } else {
      return await Controller.cart.removeFromCart(
          userModel: userModel ,
          productId: productModel.id ,
          ref: ref ,
          providerCart: fetchCartData() ,
          index: _cartIndex(ref: ref, model: productModel)
      ).then((value) {
        /// To get Index of Cart

        _increaseTotalAndQuantityForDetailsScreen(ref: ref, response: value);
        _increaseTotalAndQuantityForProductScreen(ref: ref, response: value, productModel: productModel);

        /// This Function are executed in State 200&201
        _getTotalPriceOfProductAndIncreaseCount(ref: ref);
      });
    }
  }


  @override
  Future<void> deleteFromCart({
    required WidgetRef ref ,
    required BaseProductModel productModel ,
    required BaseProductDetailsModel model ,
    required UserModel userModel ,
    required BuildContext context
  }) async {
    await Controller.cart.deleteCart(
        userModel: userModel ,
        productId: productModel.id ,
        context: context ,
        providerCart: fetchCartData() ,
        ref: ref
    ).then((value) {
      ref.read(fetchProductDetailsProv).changeBoolValue();

      ref.read(fetchProductDetailsProv)
          .update(index: 9, value: 1);
      ref.read(fetchProductDetailsProv)
          .update(index: 10, value: model.price);

      ref.read(fetchCartData()).removeAt(
          index: _cartIndex(ref: ref, model: productModel)
      );

    });

  }

  void _increaseTotalAndQuantityForDetailsScreen({
    required WidgetRef ref , required Response response
  }) {
      ref.read(fetchProductDetailsProv)
          .update(index: 9, value: response.data['data']['quantity']);
      ref.read(fetchProductDetailsProv)
          .update(index: 10, value: response.data['data']['total']);
    }

  void _increaseTotalAndQuantityForProductScreen({
    required WidgetRef ref , required Response response ,
    required BaseProductModel productModel
  }) {
    final int index = _cartIndex(ref: ref, model: productModel);

    ref.read(fetchCartData()).updateAt(
        index: index,
        key: 'total',
        value: response.data['data']['total']
    );

    /// Function's Increase Quantity
    ref.read(fetchCartData()).updateAt(
        index: index,
        key: 'quantity',
        value: response.data['data']['quantity']
    );
  }


    int _getTotalPriceOfProductAndIncreaseCount({required WidgetRef ref}) {
      /// To Get Count of Product
      final int totalPrice = ref.read(fetchCartData()).dataList
          .map((e) => e['total'])
          .reduce((value, element) => value + element);

      /// To Increase Total Price
      ref.read(fetchTotalAndCountCartData()).updateAt(
          index: 0 ,
          key: "total" ,
          value: totalPrice
      );

      return totalPrice;
    }


    int _cartIndex({required WidgetRef ref, required BaseProductModel model}) {
    final int cartIndex = ref.read(fetchCartData()).dataList
        .map((e) => e['product']['id'])
        .toList()
        .indexWhere((element) => element.contains(model.id)
    );
    return cartIndex;
  }
}