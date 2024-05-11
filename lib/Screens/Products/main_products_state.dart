import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseProductState {
  final TextEditingController controller = TextEditingController();
  final selectedProv = ChangeNotifierProvider((ref) => IntegerProvider());

  ProviderListenable<FetchDataProvider> fetchCartData();

  ProviderListenable<FetchDataProvider> fetchTotalAndCountCartData();

  ProviderListenable<BooleanProvider> cartIndicatorProvider();


  Future<void> navigateToDetailsScreen({
    required BuildContext context ,
    required UserModel userModel ,
    required BaseProductModel productModel ,
    required int index ,
    required InitProducts state ,
  });

  Future<void> addToCart({
    required WidgetRef ref ,
    required InitProducts state ,
    required UserModel userModel  ,
    required BaseProductModel model ,
    required BuildContext context
  });

}



class ProductState extends BaseProductState {

  @override
  Future<void> navigateToDetailsScreen({
    required BuildContext context ,
    required UserModel userModel ,
    required BaseProductModel productModel ,
    required int index ,
    required InitProducts state ,
  }) async {

    late List<dynamic> arguments;


    final bool isProductExist = await Controller.product
        .isProductExist(
        userModel: userModel ,
        productModel: productModel
    );

    if(isProductExist) {
      final (int,int) values = await Controller.product
      .getProductAndQuantity(userModel: userModel, productModel: productModel);

      arguments = <dynamic>[
        userModel , productModel  , index , state ,
        values.$1, values.$2, isProductExist
      ];
    } else {
      arguments = <dynamic>[
        userModel , productModel  , index , state ,
        1, productModel.price , isProductExist
      ];
    }


    if(context.mounted) {
      await Navigator.of(context).pushNamed(
          RouteGenerators.productDetails  ,
          arguments: arguments
      );
    }

  }


  @override
  ProviderListenable<FetchDataProvider> fetchCartData() {
    return Controller.cart.fetchCartData;
  }

  @override
  ProviderListenable<FetchDataProvider> fetchTotalAndCountCartData() {
    return Controller.cart.fetchTotalAndCountCartData;
  }

  @override
  ProviderListenable<BooleanProvider> cartIndicatorProvider() {
    // TODO: implement cartIndicatorProvider
    return Controller.cart.cartIndicatorProv;
  }

  @override
  Future<void> addToCart({
    required WidgetRef ref ,
    required InitProducts state ,
    required UserModel userModel  ,
    required BaseProductModel model ,
    required BuildContext context
  }) async {
    try {
      await Controller.cart.addToCart(
          productId: model.id ,
          userModel: userModel,
          ref: ref,
          providerCart: fetchCartData(),
          context: context
      ).then((value) async {
        final Map<String,dynamic> data = await value.data['data'];

        if(value.statusCode == 201) {
          /// Functions Add Product Item
          ref.read(fetchCartData()).add(value: data);
          ref.read(fetchTotalAndCountCartData()).updateInteger(
              index: 0,
              plus: true ,
              updateKey: 'count'
          );


          /// This Function are executed in State 200&201
          _getTotalPriceOfProductAndIncreaseCount(ref: ref);


          if(context.mounted) {
            return _productAlert(
                text: LangEnum.success.name,
                context: context
            );
          }
        } else if(value.statusCode == 200) {

          /// To get Index of Cart
          final int cartIndex = ref.read(fetchCartData()).dataList
              .map((e) => e['product']['id'])
              .toList()
              .indexWhere((element) => element.contains(value.data['data']['id']));

          /// Function's Increase Total Price
          ref.read(fetchCartData()).updateAt(
              index: cartIndex,
              key: 'total' ,
              value: value.data['data']['total']
          );

          /// Function's Increase Quantity
          ref.read(fetchCartData()).updateAt(
              index: cartIndex ,
              key: 'quantity' ,
              value: value.data['data']['quantity']
          );

          /// This Function are executed in State 200&201
          _getTotalPriceOfProductAndIncreaseCount(ref: ref);

          if(context.mounted) {
            return _productAlert(
                text: "${data['quantity']}",
                context: context
            );
          }
        } else {
          if(context.mounted) {
            return _productAlert(text: LangEnum.cartAdded.name, context: context);
          }
        }


      });
      
    } on DioException catch(_) {
      if(context.mounted) {
        _productAlert(
            text: LangEnum.internet.name ,
            context: context
        );
      }
    }
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


  ScaffoldMessengerState _productAlert({
    required String text , required BuildContext context
}) {
    return App.alertWidgets.snackBar(
        text: text,
        context: context
    );
  }

}



abstract class BaseFetchProductData {

  final fetchData = ChangeNotifierProvider((ref) => FetchDataProvider());

  final ScrollController scrollController = ScrollController();

  final productControllerProv = ChangeNotifierProvider((ref) => IntegerProvider());

  bool loadMore = false;

  String urlProduct();

  int pageProduct = 1;

  int limitProduct = 3;

  Future<void> initFetchProductData({
    required WidgetRef ref ,
  });


  void disposeFetchProductData({
    required WidgetRef ref
  });


  Future<void> refresh({
    required WidgetRef ref
  });
}


class AllProductState extends BaseFetchProductData {

  @override
  String urlProduct() {
    limitProduct = 5;
    return '${App.strings.allProductUrl}/?limit=$limitProduct&page=$pageProduct';
  }


  @override
  Future<void> initFetchProductData({
    required WidgetRef ref
  }) async {
    await ref.read(fetchData)
        .fetchData(
        url: urlProduct() ,
        limit: limitProduct ,
        page: pageProduct++
    );

    scrollController.addListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });
  }


  @override
  void disposeFetchProductData({
    required WidgetRef ref
  }) {
    scrollController.removeListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });
  }


  @override
  Future<void> refresh({
    required WidgetRef ref
  }) async {
    pageProduct = 1;
    await ref.refresh(fetchData)
        .fetchData(url: urlProduct(), limit: limitProduct, page: pageProduct++);
    //scrollController.jumpTo(0);
    scrollController.jumpTo(0);
  }

}


class ProductFashionState extends BaseFetchProductData {

  @override
  String urlProduct() {
    const String id = '65daa5f8bfad8c6cec7f29a0';
    return '${App.strings.productAndCategory}/$id/?limit=$limitProduct&page=$pageProduct';}


  @override
  Future<void> initFetchProductData({
    required WidgetRef ref,
  }) async {
    await ref.read(fetchData)
        .fetchData(
        url: urlProduct() ,
        limit: limitProduct ,
        page: pageProduct++
    );

    scrollController.addListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });
  }


  @override
  void disposeFetchProductData({
    required WidgetRef ref
  }) {
    scrollController.removeListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });
  }

  @override
  Future<void> refresh({
    required WidgetRef ref
  }) async {
    pageProduct = 1;
    await ref.refresh(fetchData)
        .fetchData(url: urlProduct(), limit: limitProduct, page: pageProduct++);
    scrollController.jumpTo(0);
  }


}


class ProductTechState extends BaseFetchProductData {

  @override
  String urlProduct() {
    const String id = '65dac1de3819ead02a411d08';
    return '${App.strings.productAndCategory}/$id/?limit=$limitProduct&page=$pageProduct';
  }


  @override
  Future<void> initFetchProductData({
    required WidgetRef ref,
  }) async {
    await ref.read(fetchData)
        .fetchData(
        url: urlProduct() ,
        limit: limitProduct ,
        page: pageProduct++
    );

    scrollController.addListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });

  }

  @override
  void disposeFetchProductData({
    required WidgetRef ref
  }) {
    scrollController.removeListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });
  }



  @override
  Future<void> refresh({
    required WidgetRef ref
  }) async {
    pageProduct = 1;
    await ref.refresh(fetchData)
        .fetchData(url: urlProduct(), limit: limitProduct, page: pageProduct++);
      scrollController.jumpTo(0);
  }


}


class ProductHealthState extends BaseFetchProductData {

  @override
  String urlProduct() {
    const String id = '65dac3e16b922068b1b4f567';
    return '${App.strings.productAndCategory}/$id/?limit=$limitProduct&page=$pageProduct';
  }


  @override
  Future<void> initFetchProductData({
    required WidgetRef ref
  }) async {
    await ref.read(fetchData)
        .fetchData(
        url: urlProduct() ,
        limit: limitProduct ,
        page: pageProduct++
    );

   scrollController.addListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });
  }



  @override
  void disposeFetchProductData({
    required WidgetRef ref
  }) {
    scrollController.removeListener(() async {
      ref.read(productControllerProv)
          .equalValueInteger(scrollController.offset.toInt());

      if (
      scrollController.position.maxScrollExtent
          ==
          scrollController.offset
      ) {
        await ref.read(fetchData)
            .fetchData(
            url: urlProduct() ,
            limit: limitProduct ,
            page: pageProduct++
        );
      }
    });
  }


  @override
  Future<void> refresh({
    required WidgetRef ref
  }) async {
    pageProduct = 1;
    await ref.refresh(fetchData)
        .fetchData(url: urlProduct(), limit: limitProduct, page: pageProduct++);
    //scrollController.jumpTo(0);
      scrollController.jumpTo(0);
  }


}