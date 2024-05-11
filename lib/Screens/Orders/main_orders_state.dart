import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/orders_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/GoogleMap/google_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



abstract class BaseOrdersState {
  final ScrollController scrollController = ScrollController();
  bool loadMore = false;

  int pageOrders = 1;

  int limitOrders = 7;

  ProviderListenable<FetchDataProvider> fetchOrderData();

  Future<void> navigateToGoogleMap({
    required BuildContext context ,
    required BaseOrdersModel ordersModel ,
    required UserModel userModel
  });

  String urlOrders(UserModel userModel);

  Future<void> fetchOrders({
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



class OrdersState extends BaseOrdersState {

  @override
  Future<void> navigateToGoogleMap({
    required BuildContext context ,
    required BaseOrdersModel ordersModel ,
    required UserModel userModel
  }) async {
    // TODO: implement navigateToGoogleMap
    await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> GoogleMapPage(
        lng: double.parse(ordersModel.long) ,
        lat: double.parse(ordersModel.lat) ,
        isUser: false ,
        userModel: userModel
    ))
    );
  }

  @override
  ProviderListenable<FetchDataProvider> fetchOrderData() {
    return Controller.order.fetchOrderData;
  }


  @override
  String urlOrders(UserModel userModel) {
    return '${App.strings.order}/${userModel.id}/?limit=$limitOrders&page=$pageOrders';
  }


  // @override
  // Future<void> fetchOrders({
  //   required WidgetRef ref ,
  //   required UserModel userModel
  // })  async {
  //   await ref.read(fetchOrderData())
  //       .fetchData(
  //       url: urlOrders(userModel) ,
  //       limit: limitOrders ,
  //       page: pageOrders++
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
  //           url: urlOrders(userModel) ,
  //           limit: limitOrders ,
  //           page: pageOrders++
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
  //           url: urlOrders(userModel) ,
  //           limit: limitOrders ,
  //           page: pageOrders++ ,
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
  //   pageOrders = 1;
  //   await ref.refresh(Controller.order.fetchOrderData)
  //       .fetchData(url: urlOrders(userModel), limit: limitOrders, page: pageOrders++,token: userModel.token);
  //   //scrollController.jumpTo(0);
  //   //scrollCartController.jumpTo(0);
  // }
  //
  //

  @override
  Future<void> fetchOrders({
    required WidgetRef ref ,
    required UserModel userModel
  }) async {
    await ref.read(fetchOrderData())
        .fetchData(
        url: urlOrders(userModel) ,
        limit: limitOrders ,
        page: pageOrders++ ,
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
            url: urlOrders(userModel) ,
            limit: limitOrders ,
            page: pageOrders++ ,
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
            url: urlOrders(userModel) ,
            limit: limitOrders ,
            page: pageOrders++ ,
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
    pageOrders = 1;
    await ref.refresh(Controller.order.fetchOrderData)
        .fetchData(url: urlOrders(userModel), limit: limitOrders, page: pageOrders++,token: userModel.token);
    //scrollController.jumpTo(0);
    //scrollCartController.jumpTo(0);
  }


}