import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



abstract class BaseCartController {
  final fetchCartData = ChangeNotifierProvider((ref) => FetchDataProvider());
  final fetchTotalAndCountCartData = ChangeNotifierProvider((ref) => FetchDataProvider());
  final cartIndicatorProv = ChangeNotifierProvider((ref) => BooleanProvider());


  Future<BaseCartModel> fetchCartByID({
    required UserModel userModel ,
    required String productID ,
    required BuildContext context ,
  });


  Future<Response> addToCart({
    required UserModel userModel  ,
    required String productId ,
    required WidgetRef ref ,
    required BuildContext context ,
    required ProviderListenable<FetchDataProvider> providerCart
  });

  Future<Response> removeFromCart({
    required UserModel userModel  ,
    required String productId ,
    required WidgetRef ref ,
    required int index ,
    required ProviderListenable<FetchDataProvider> providerCart
  });


  Future<Response> deleteCart({
    required UserModel userModel  ,
    required String productId ,
    required WidgetRef ref ,
    required BuildContext context ,
    required ProviderListenable<FetchDataProvider> providerCart
  });


  Future<Response> deleteAllCart({
    required UserModel userModel  ,
    required BuildContext context
  });

  Future<void> getCountAndTotal({
    required UserModel userModel  ,
    required WidgetRef ref
  });
}


class CartController extends BaseCartController {


  @override
  Future<BaseCartModel> fetchCartByID({
    required UserModel userModel ,
    required String productID ,
    required BuildContext context ,
  }) async {
    try {
      final Response response = await App.dio.get(
          url: '${App.strings.cartAndAll}/${userModel.id}',
          token: userModel.token,
          data: {
            "product": productID
          }
      );

      final Map<String,dynamic> data = response.data['data'];

      final BaseCartModel model = CartModel.fromJson(data);


      if(response.statusCode == 200) {
        return model;
      } else {
        if(context.mounted) {
          App.alertWidgets.snackBar(text: LangEnum.internet.name, context: context);
        }
        throw Exception("No Data");
      }

    } on DioException catch(_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.internet.name, context: context);
      }
      throw Exception("No Data");
    }

  }

  @override
  Future<Response> addToCart({
    required UserModel userModel  ,
    required String productId ,
    required WidgetRef ref ,
    required ProviderListenable<FetchDataProvider> providerCart ,
    required BuildContext context
  }) async {
    try {
      final Response response = await App.dio.post(
          url: '${App.strings.addToCart}/${userModel.id}', data: {
        "product": productId ,
      }, token: userModel.token);
     // final Map<String,dynamic> data = await response.data['data'];

      if(response.statusCode == 201 || response.statusCode == 200) {
        return response;
      }else {
        throw Exception("No Data");
      }

    } catch (_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.internet.name, context: context);
      }
      throw Exception("No Data");
    }

  }




  @override
  Future<Response> removeFromCart({
    required UserModel userModel  ,
    required String productId ,
    required WidgetRef ref ,
    required int index ,
    required ProviderListenable<FetchDataProvider> providerCart
  }) async {
    try {
      final Response response = await App.dio.update(
          url: '${App.strings.addToCart}/${userModel.id}', data: {
        "product": productId
      }, token: userModel.token);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("Error");
      }


    } catch (e) {
      throw Exception("Error");
    }

  }



  @override
  Future<Response> deleteCart({
    required UserModel userModel  ,
    required String productId ,
    required WidgetRef ref ,
    required ProviderListenable<FetchDataProvider> providerCart ,
    required BuildContext context
  }) async {
    try {

      final Response response = await App.dio.delete(
          url: '${App.strings.addToCart}/${userModel.id}', data: {
        "product": productId
      }, token: userModel.token );


      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("Error");
      }

    } catch (_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.internet.name, context: context);
      }
      throw Exception("Error");
    }

  }


  @override
  Future<Response> deleteAllCart({
    required UserModel userModel  ,
    required BuildContext context
  }) async {
    try {

      final Response response = await App.dio.delete(
          url: '${App.strings.cartAndAll}/${userModel.id}' ,
          token: userModel.token
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("Error");
      }

    } catch (_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.internet.name, context: context);
      }
      throw Exception("Error");
    }

  }


  @override
  Future<void> getCountAndTotal({
    required UserModel userModel  ,
    required WidgetRef ref ,
  }) async {
    try {
      final Response response = await App.dio.get(
          url: '${App.strings.countAndTotal}/${userModel.id}',
          token: userModel.token);

      final data = await response.data;

      if (response.statusCode == 200) {

        ref.read(fetchTotalAndCountCartData).add(value: data);

      }

    } catch (_) {}

  }
}