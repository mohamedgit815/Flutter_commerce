
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseAdminOrdersState {
  final ScrollController scrollController = ScrollController();
  bool loadMore = false;

  int pageAdminOrders = 1;

  int limitAdminOrders = 7;

  ProviderListenable<FetchDataProvider> fetchOrderData();

  String urlAdminOrders(UserModel userModel);

  Future<void> fetchAdminOrders({
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



class AdminOrdersState extends BaseAdminOrdersState {

  @override
  ProviderListenable<FetchDataProvider> fetchOrderData() {
    return Controller.order.fetchAdminOrderData;
  }


  @override
  String urlAdminOrders(UserModel userModel) {
    return '${App.strings.adminOrder}/${userModel.id}/?limit=$limitAdminOrders&page=$pageAdminOrders';
  }


  // @override
  // Future<void> fetchAdminOrders({
  //   required WidgetRef ref ,
  //   required UserModel userModel
  // })  async {
  //   await ref.read(fetchOrderData())
  //       .fetchData(
  //       url: urlAdminOrders(userModel) ,
  //       limit: limitAdminOrders ,
  //       page: pageAdminOrders++
  //   );
  //
  //   scrollController.addListener(() async {
  //     // ref.read(productControllerProv)
  //     //     .equalValueInteger(scrollController.offset.toInt());
  //
  //     if (
  //     scrollController.position.maxScrollExtent
  //         ==
  //         scrollController.offset
  //     ) {
  //       await ref.read(fetchOrderData())
  //           .fetchData(
  //           url: urlAdminOrders(userModel) ,
  //           limit: limitAdminOrders ,
  //           page: pageAdminOrders++
  //       );
  //     }
  //   });
  // }
  //
  //
  // @override
  // void disposeFetchCartData({
  //   required WidgetRef ref ,
  //   required UserModel userModel
  // }) {
  //   scrollController.removeListener(() async {
  //     // ref.read(cartControllerProv)
  //     //     .equalValueInteger(scrollCartController.offset.toInt());
  //
  //     if (
  //     scrollController.position.maxScrollExtent
  //         ==
  //         scrollController.offset
  //     ) {
  //       await ref.read(fetchOrderData())
  //           .fetchData(
  //           url: urlAdminOrders(userModel) ,
  //           limit: limitAdminOrders ,
  //           page: pageAdminOrders++ ,
  //           token: userModel.token
  //       );
  //     }
  //   });
  // }
  //
  //
  // @override
  // Future<void> refresh({
  //   required WidgetRef ref ,
  //   required UserModel userModel
  // }) async {
  //   pageAdminOrders = 1;
  //   await ref.refresh(Controller.order.fetchOrderData)
  //       .fetchData(url: urlAdminOrders(userModel), limit: limitAdminOrders, page: pageAdminOrders++,token: userModel.token);
  //   //scrollController.jumpTo(0);
  //   //scrollCartController.jumpTo(0);
  // }
  //
  //

  @override
  Future<void> fetchAdminOrders({
    required WidgetRef ref ,
    required UserModel userModel
  }) async {
    await ref.read(fetchOrderData())
        .fetchData(
        url: urlAdminOrders(userModel) ,
        limit: limitAdminOrders ,
        page: pageAdminOrders++ ,
        token: userModel.token
    );

    scrollController.addListener(() async {
      // ref.read(productControllerProv)
      //     .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchOrderData())
            .fetchData(
            url: urlAdminOrders(userModel) ,
            limit: limitAdminOrders ,
            page: pageAdminOrders++ ,
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
    scrollController.removeListener(() async {
      // ref.read(cartControllerProv)
      //     .equalValueInteger(scrollCartController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(Controller.cart.fetchCartData)
            .fetchData(
            url: urlAdminOrders(userModel) ,
            limit: limitAdminOrders ,
            page: pageAdminOrders++ ,
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
    pageAdminOrders = 1;
    await ref.refresh(Controller.order.fetchOrderData)
        .fetchData(url: urlAdminOrders(userModel), limit: limitAdminOrders, page: pageAdminOrders++,token: userModel.token);
    //scrollController.jumpTo(0);
    //scrollCartController.jumpTo(0);
  }


}