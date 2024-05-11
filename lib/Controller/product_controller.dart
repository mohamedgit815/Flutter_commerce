import 'package:commerce/App/app.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:dio/dio.dart';


abstract class BaseProductController {
  Future<bool> isProductExist({
    required UserModel userModel ,
    required BaseProductModel productModel
  });

  Future<(int,int)> getProductAndQuantity({
    required UserModel userModel ,
    required BaseProductModel productModel
  });
}


class ProductController extends BaseProductController {

  @override
  Future<bool> isProductExist({
    required UserModel userModel ,
    required BaseProductModel productModel
  }) async {
       final Response response = await App.dio.get(
          url: "${App.strings.productExistUrl}/${userModel.id}/${productModel.id}" ,
          token: userModel.token
      );

       final bool success = response.data['success'];
       return success;
  }

  @override
  Future<(int,int)> getProductAndQuantity({
    required UserModel userModel ,
    required BaseProductModel productModel
  }) async {
    final Response response = await App.dio.get(
        url: "${App.strings.productExistUrl}/${userModel.id}/${productModel.id}" ,
        token: userModel.token
    );

    final int quantity = await response.data['data']['quantity'];
    final int total = await response.data['data']['total'];

    return (quantity, total);
  }

}