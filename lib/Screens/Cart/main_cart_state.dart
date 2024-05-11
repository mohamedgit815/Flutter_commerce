
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Cart/init_cart.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseCartState {
  final ScrollController scrollCartController = ScrollController();

  final cartControllerProv = ChangeNotifierProvider((ref) => IntegerProvider());

  final changeScrollNotification = ChangeNotifierProvider((ref) => BooleanProvider());

  bool loadMore = false;



  int pageCart = 1;

  int limitCart = 7;

  ProviderListenable<FetchDataProvider> fetchCartData();

  ProviderListenable<FetchDataProvider> fetchTotalAndCountCartData();


  Future<Object?> navigateToOrderScreen({
    required TotalAndCountModel model ,
    required UserModel userModel ,
    required BuildContext context
  });

  Future<void> navigateToDetailsScreen({
    required BuildContext context ,
    required UserModel userModel ,
    required BaseCartModel cartModel ,
    required InitCart state ,
    required int index ,
    required WidgetRef ref
  });


  Future<void> addTotalAndCount({
    required WidgetRef ref,
    required UserModel userModel
  });

  Future<Response> addToCart({
    required UserModel userModel ,
    required BaseCartModel model ,
    required WidgetRef ref ,
    required BuildContext context ,
    required int index
  });


  Future<Response> removeFromCart({
    required UserModel userModel ,
    required BaseCartModel model ,
    required WidgetRef ref ,
    required int index
  });


  Future<void> deleteOnlyCart({
    required UserModel userModel ,
    required String productId ,
    required WidgetRef ref ,
    required BuildContext context ,
    required int index ,
  });


  Future<void> deleteAllCarts({
    required UserModel userModel ,
    required WidgetRef ref ,
    required BuildContext context ,
  });

  String urlCart(UserModel userModel);

  Future<void> initFetchCartData({
    required WidgetRef ref ,
    required UserModel userModel
  });


  void disposeFetchCartData({
    required WidgetRef ref ,
    required UserModel userModel
  });


  Future<void> refresh({
    required WidgetRef ref ,
    required UserModel userModel
  });
}



class CartState extends BaseCartState {

  @override
  ProviderListenable<FetchDataProvider> fetchCartData() {
    return Controller.cart.fetchCartData;
  }


  @override
  ProviderListenable<FetchDataProvider> fetchTotalAndCountCartData() {
    return Controller.cart.fetchTotalAndCountCartData;
  }

  @override
  Future<Object?> navigateToOrderScreen({
    required TotalAndCountModel model ,
    required UserModel userModel ,
    required BuildContext context
  }) async {
    final List data = [
      userModel ,
      model
    ];
    return await Navigator.of(context)
        .pushNamed(
        RouteGenerators.paymentsScreen   ,
        arguments: data
    );
  }


  @override
  Future<void> navigateToDetailsScreen({
    required BuildContext context ,
    required UserModel userModel ,
    required BaseCartModel cartModel ,
    required InitCart state ,
    required int index ,
    required WidgetRef ref
  }) async {

    late TotalAndCountModel totalAndCountModel;

    if(ref.read(state.main.fetchTotalAndCountCartData()).dataList.isNotEmpty) {
      totalAndCountModel = TotalAndCountModel.fromJson(
          ref.read(state.main.fetchTotalAndCountCartData()).dataList.elementAt(0)
      );
    } else {
      totalAndCountModel = const TotalAndCountModel(totalCount: 0, totalPrice: 0);
    }


    final List<dynamic> arguments = <dynamic>[
      userModel , cartModel , totalAndCountModel , index , state
    ];


    if(context.mounted) {
      await Navigator.of(context).pushNamed(
          RouteGenerators.cartDetails ,
          arguments: arguments
      );
    }
  }


  @override
  Future<void> addTotalAndCount({
    required WidgetRef ref ,
    required UserModel userModel
  }) async {
    // TODO: implement addTotalAndCount
      return await Controller.cart.getCountAndTotal(
          userModel: userModel ,
          ref: ref
      );
  }


  @override
  Future<Response> addToCart({
    required UserModel userModel ,
    required BaseCartModel model ,
    required WidgetRef ref ,
    required BuildContext context ,
    required int index
  }) async {
    try{
      final Response<dynamic> response = await Controller.cart.addToCart(
          userModel: userModel ,
          productId: model.id ,
          ref: ref ,
          providerCart: fetchCartData(),
          context: context
      );

      if(response.statusCode == 200) {
        ref.read(fetchCartData()).updateAt(
            index: index ,
            key: "quantity" ,
            value: response.data['data']['quantity']
        );

        ref.read(fetchCartData()).updateAt(
            index: index,
            key: "total",
            value: response.data['data']['total']
        );


        ref.read(fetchTotalAndCountCartData()).updateAt(
            index: 0 ,
            key: "total" ,
            value: _totalPrice(ref: ref).toInt()
        );

        return response;

      } else {
        throw Exception("No Data");
      }

    } on DioException catch(_) {
      throw Exception("No Data");
    }

    //
    // await Controller.cart.addToCart(
    //     userModel: userModel ,
    //     productId: model.id ,
    //     ref: ref ,
    //     providerCart: fetchCartData(),
    //     context: context
    // ).then((value) async {
    //
    //   ref.read(fetchCartData()).updateAt(
    //       index: index ,
    //       key: "quantity" ,
    //       value: value.data['data']['quantity']
    //   );
    //
    //   ref.read(fetchCartData()).updateAt(
    //       index: index,
    //       key: "total",
    //       value: value.data['data']['total']
    //   );
    //
    //
    //   ref.read(fetchTotalAndCountCartData()).updateAt(
    //       index: 0 ,
    //       key: "total" ,
    //       value: _totalPrice(ref: ref).toInt()
    //   );
    //
    //
    //   return value;
    // }).catchError((err){
    //   return err;
    // });
  }


  @override
  Future<Response> removeFromCart({
    required UserModel userModel ,
    required BaseCartModel model ,
    required WidgetRef ref ,
    required int index
  }) async {

    try{

      final Response response = await Controller.cart.removeFromCart(
          userModel: userModel,
          productId: model.id,
          ref: ref,
          providerCart: fetchCartData(),
          index: index
      );

      if(response.statusCode == 200) {


        ref.read(fetchCartData()).updateAt(
            index: index,
            key: "quantity",
            value: response.data['data']['quantity']
        );

        ref.read(fetchCartData()).updateAt(
            index: index,
            key: "total",
            value: response.data['data']['total']
        );

        ref.read(fetchTotalAndCountCartData()).updateAt(
            index: 0 ,
            key: "total" ,
            value: _totalPrice(ref: ref)
        );

        return response;

      } else {
        throw Exception("Else---------------------------------------------");
      }



    } on DioException catch(_) {
      throw Exception("DioException------------------------------------------");
    }

  }


  @override
  Future<void> deleteOnlyCart({
    required UserModel userModel ,
    required String productId ,
    required WidgetRef ref ,
    required BuildContext context ,
    required int index ,
  }) async {
    // TODO: implement deleteCartCart
    await Controller.cart.deleteCart(
        userModel: userModel,
        productId: productId,
        ref: ref,
        providerCart: fetchCartData(),
        context: context
    ).then((value) {
      ref.read(fetchCartData()).removeAt(index: index);
      ref.read(fetchTotalAndCountCartData()).updateInteger(
          index: 0,
          plus: false ,
          updateKey: 'count'
      );

      ref.read(fetchTotalAndCountCartData()).updateAt(
          index: 0 ,
          key: "total" ,
          value: _totalPrice(ref: ref)
      );

    });
  }


  @override
  Future<void> deleteAllCarts({
    required UserModel userModel ,
    required WidgetRef ref ,
    required BuildContext context ,
  }) async {
    // TODO: implement deleteCartCart
    await Controller.cart.deleteAllCart(
        userModel: userModel,
        context: context
    ).then((value) {
      ref.read(fetchTotalAndCountCartData()).updateAt(
          index: 0,
          key: 'count',
          value: 0
      );

      ref.read(fetchCartData()).removeAll();

      ref.read(fetchTotalAndCountCartData()).updateAt(
          index: 0 ,
          key: "total" ,
          value: 0
      );

    });
  }

  @override
  String urlCart(UserModel userModel) {
    return '${App.strings.addToCart}/${userModel.id}/?limit=$limitCart&page=$pageCart';
  }


  @override
  Future<void> initFetchCartData({
    required WidgetRef ref ,
     required UserModel userModel
  }) async {
    await ref.read(Controller.cart.fetchCartData)
        .fetchData(
        url: urlCart(userModel) ,
        limit: limitCart ,
        page: pageCart++ ,
        token: userModel.token
    );

    scrollCartController.addListener(() async {
      ref.read(cartControllerProv)
          .equalValueInteger(scrollCartController.offset.toInt());

      if (
      scrollCartController.position.maxScrollExtent
          ==
          scrollCartController.offset
      ) {
        await ref.read(Controller.cart.fetchCartData)
            .fetchData(
            url: urlCart(userModel) ,
            limit: limitCart ,
            page: pageCart++ ,
            token: userModel.token
        );
      }
    });
  }


  @override
  void disposeFetchCartData({
    required WidgetRef ref ,
    required UserModel userModel
  }) {
    scrollCartController.removeListener(() async {
      ref.read(cartControllerProv)
          .equalValueInteger(scrollCartController.offset.toInt());

      if (
      scrollCartController.position.maxScrollExtent
          ==
          scrollCartController.offset
      ) {
        await ref.read(Controller.cart.fetchCartData)
            .fetchData(
            url: urlCart(userModel) ,
            limit: limitCart ,
            page: pageCart++ ,
            token: userModel.token
        );
      }
    });
  }


  @override
  Future<void> refresh({
    required WidgetRef ref ,
    required UserModel userModel
  }) async {
    pageCart = 1;
    await ref.refresh(Controller.cart.fetchCartData)
        .fetchData(url: urlCart(userModel), limit: limitCart, page: pageCart++,token: userModel.token);
    //scrollController.jumpTo(0);
    //scrollCartController.jumpTo(0);
  }


  int _totalPrice({required WidgetRef ref}) {
    return ref
        .read(fetchCartData())
        .dataList
        .map((e) => e['total'])
        .reduce((value, element) => value + element);
  }
}