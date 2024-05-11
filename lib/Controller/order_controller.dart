import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/orders_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseOrderController {
  final fetchOrderData = ChangeNotifierProvider((ref) => FetchDataProvider());
  final fetchAdminOrderData = ChangeNotifierProvider((ref) => FetchDataProvider());

  Future<void> purchaseProducts({
    required UserModel userModel ,
    required BuildContext context ,
    required String lang ,
    required String lit ,
    required String city ,
    required String zip ,
    required String country ,
    required String phone ,
  });


  Future<void> updateState({
    required UserModel userModel ,
    required BuildContext context ,
  });

  Future<BaseOrdersModel> getOrders({
    required UserModel userModel ,
    required String productID ,
    required BuildContext context ,
  });
}


class OrderController extends BaseOrderController {


  @override
  Future<void> purchaseProducts({
    required UserModel userModel ,
    required BuildContext context ,
    required String lang ,
    required String lit ,
    required String city ,
    required String zip ,
    required String country ,
    required String phone ,
  }) async {
    try {

       final Response response = await App.dio.post(
          url: '${App.strings.order}/${userModel.id}', data: {
               "shippingAddress1": lang ,
               "shippingAddress2": lit ,
               "city": city,
               "country": country ,
               "zip": zip ,
               "phone": phone ,
               "status":"pending"
      }, token: userModel.token);

       if(response.statusCode == 201) {
         if (context.mounted) {
           App.alertWidgets.snackBar(
               text: LangEnum.success.name, context: context);
         }
       }

    } on DioException catch (e) {
      if (context.mounted) {
        App.alertWidgets.snackBar(
            text: LangEnum.internet.name, context: context
        );
      }

      throw Exception(e.response!.data['message']);
    }
  }


  @override
  Future<void> updateState({
    required UserModel userModel ,
    required BuildContext context ,
  }) async {
    try {
      await App.dio.update(
          url: '${App.strings.order}/${userModel.id}', data: {
        "status": "Done" ,
      }, token: userModel.token );
      // order on way , Done

    } catch (_) {
      if (context.mounted) {
        App.alertWidgets.snackBar(
            text: LangEnum.internet.name, context: context);
      }
      throw Exception("No Data");
    }
  }


  @override
  Future<BaseOrdersModel> getOrders({
    required UserModel userModel ,
    required String productID ,
    required BuildContext context ,
  }) async {
    try {
      final Response response = await App.dio.get(
          url: '${App.strings.order}/${userModel.id}',
          token: userModel.token,
      );

      final Map<String,dynamic> data = response.data['data'];

      final BaseOrdersModel model = OrdersModel.fromJson(data);


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


}