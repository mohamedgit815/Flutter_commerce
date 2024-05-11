import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Cart/init_cart.dart';
import 'package:commerce/Screens/CartDetails/init_cart_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseCartDetailsState {

  final fetchCartCartDetailsProv = ChangeNotifierProvider((ref) => FetchDataProvider());
  final paymentProv = ChangeNotifierProvider((ref) => IntegerProvider());

  Future<void> fetchCartDetails({
    required WidgetRef ref ,
    required BaseCartModel model ,
    required TotalAndCountModel totalAndCountModel
  });

  (BaseCartModel ,TotalAndCountModel) getCartDetails({required WidgetRef ref});

  Future<void> addToCart({
    required InitCart cartState ,
    required InitCartDetails state ,
    required UserModel userModel ,
    required WidgetRef ref ,
    required BuildContext context ,
    required BaseCartModel cartModel ,
    required int index
  });

  Future<void> removeFromCart({
    required InitCart cartState ,
    required InitCartDetails state ,
    required UserModel userModel ,
    required WidgetRef ref ,
    required BuildContext context ,
    required BaseCartModel cartModel ,
    required int index
  });

}

class CartDetailsState extends BaseCartDetailsState {

  @override
  Future<void> fetchCartDetails({
    required WidgetRef ref ,
    required BaseCartModel model ,
    required TotalAndCountModel totalAndCountModel
  }) async {
      await ref.read(fetchCartCartDetailsProv).add(value: model.id);
      await ref.read(fetchCartCartDetailsProv).add(value: model.content);
      await ref.read(fetchCartCartDetailsProv).add(value: model.name);
      await ref.read(fetchCartCartDetailsProv).add(value: model.image);
      await ref.read(fetchCartCartDetailsProv).add(value: model.category);
      await ref.read(fetchCartCartDetailsProv).add(value: model.createdAt);
      await ref.read(fetchCartCartDetailsProv).add(value: model.updatedAt);
      await ref.read(fetchCartCartDetailsProv).add(value: model.price);
      await ref.read(fetchCartCartDetailsProv).add(value: model.user);
      await ref.read(fetchCartCartDetailsProv).add(value: model.total);
      await ref.read(fetchCartCartDetailsProv).add(value: model.quantity);
      await ref.read(fetchCartCartDetailsProv).add(value: totalAndCountModel.totalCount);
      await ref.read(fetchCartCartDetailsProv).add(value: totalAndCountModel.totalPrice);
  }



  @override
  (BaseCartModel, TotalAndCountModel) getCartDetails({
    required WidgetRef ref
  }) {
    final List data = ref.watch(fetchCartCartDetailsProv).dataList;


    late final BaseCartModel cartModel;
    late final TotalAndCountModel totalAndCountModel;

    if(data.isEmpty) {

      cartModel = const CartModel(
          id: "" ,
          content: "" ,
          name: "" ,
          image: "" ,
          category: "" ,
          createdAt: "" ,
          updatedAt: "" ,
          price: 0 ,
          user: "" ,
          total: 0 ,
          quantity: 0
      );
      totalAndCountModel = const TotalAndCountModel(
          totalCount: 0 ,
          totalPrice: 0
      );

    } else {

      cartModel = CartModel(
          id: data.elementAt(0),
          content: data.elementAt(1),
          name: data.elementAt(2),
          image: data.elementAt(3),
          category: data.elementAt(4),
          createdAt: data.elementAt(5),
          updatedAt: data.elementAt(6),
          price: data.elementAt(7),
          user: data.elementAt(8),
          total: data.elementAt(9),
          quantity: data.elementAt(10)
      );

      totalAndCountModel = TotalAndCountModel(
          totalCount: data.elementAt(11) ,
          totalPrice: data.elementAt(12)
      );

    }

    return (cartModel, totalAndCountModel);
  }



  @override
  Future<void> addToCart({
    required InitCart cartState ,
    required InitCartDetails state ,
    required UserModel userModel ,
    required WidgetRef ref ,
    required BuildContext context ,
    required BaseCartModel cartModel ,
    required int index
  }) async {
    return await cartState.main.addToCart(
        ref: ref ,
        userModel: userModel ,
        context: context,
        model: cartModel ,
        index: index
    ).then((value) {

      if(value.statusCode == 200) {
        ref.read(fetchCartCartDetailsProv).update(index: 9, value: value.data['data']['total']);
        ref.read(fetchCartCartDetailsProv).update(index: 10, value: value.data['data']['quantity']);
        ref.read(fetchCartCartDetailsProv).update(
            index: 12 ,
            value: _totalPrice(ref: ref,cartState: cartState)
        );
      }
    });
  }

  @override
  Future<void> removeFromCart({
    required InitCart cartState ,
    required InitCartDetails state ,
    required UserModel userModel ,
    required WidgetRef ref ,
    required BuildContext context ,
    required BaseCartModel cartModel ,
    required int index
  }) async {
     if(ref.read(fetchCartCartDetailsProv).dataList[10] == 1) {

       return;

     } else {
       await cartState.main.removeFromCart(
           userModel: userModel ,
           model: cartModel ,
           ref: ref ,
           index: index
       ).then((value) {
         ref.read(fetchCartCartDetailsProv).update(index: 9, value: value.data['data']['total']);
         ref.read(fetchCartCartDetailsProv).update(index: 10, value: value.data['data']['quantity']);
         ref.read(fetchCartCartDetailsProv).update(
             index: 12 ,
             value: _totalPrice(ref: ref,cartState: cartState)
         );
       });
     }
  }

  int _totalPrice({required WidgetRef ref,required InitCart cartState}) {
    return ref
        .read(cartState.main.fetchCartData())
        .dataList
        .map((e) => e['total'])
        .reduce((value, element) => value + element);
  }

}