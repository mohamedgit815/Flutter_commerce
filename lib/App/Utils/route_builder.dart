import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Admin_Orders/main_admin_orders_screen.dart';
import 'package:commerce/Screens/Authentication/Register/main_register_screen.dart';
import 'package:commerce/Screens/BottomBar/main_bottom_bar_screen.dart';
import 'package:commerce/Screens/CartDetails/main_cart_details_screen.dart';
import 'package:commerce/Screens/GoogleMap/google_map.dart';
import 'package:commerce/Screens/GoogleMap/search_locations_page.dart';
import 'package:commerce/Screens/Orders/main_orders_screen.dart';
import 'package:commerce/Screens/Payments/main_payments_screen.dart';
import 'package:commerce/Screens/ProductDetails/main_product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RouteGenerators {
  static const String bottomScreen = '/MainBottomBarScreen';
  static const String loginScreen = '/MainLoginScreen';
  static const String registerScreen = '/MainRegisterScreen';
  static const String orderScreen = '/MainOrderScreen';
  static const String mapScreen = '/MainGoogleMapScreen';
  static const String searchPlaceScreen = '/MainSearchLocationsScreen';
  static const String adminOrderScreen = '/MainAdminOrderScreen';
  static const String paymentsScreen = '/MainPaymentsScreen';
  static const String cartDetails = '/MainDetailsScreen';
  static const String productDetails = '/MainProductDetailsScreen';



  static MaterialPageRoute<dynamic> _materialPageRoute(Widget page) {
    return MaterialPageRoute( builder: ( _ ) => page );
  }

  static CupertinoPageRoute<dynamic> _cupertinoPageRoute(Widget page) {
    return CupertinoPageRoute( builder: ( _ ) => page );
  }


  static Route<dynamic>? onGenerate(RouteSettings settings) {
    switch(settings.name) {

      case bottomScreen :
        final UserModel userModel = settings.arguments as UserModel;
        return _materialPageRoute(MainBottomBarScreen(userModel: userModel));


        case registerScreen :
          return _cupertinoPageRoute(const MainRegisterScreen());


      case searchPlaceScreen :
        return _cupertinoPageRoute(const SearchLocationsPage());

      case orderScreen :
        final UserModel data = settings.arguments as UserModel;
        return _cupertinoPageRoute(MainOrdersScreen(userModel: data));



      case adminOrderScreen :
        final UserModel data = settings.arguments as UserModel;
        return _cupertinoPageRoute(MainAdminOrdersScreen(userModel: data));


      case paymentsScreen :
        final List model = settings.arguments as List;
        return _cupertinoPageRoute(MainPaymentsScreen(userModel: model.elementAt(0),totalAndCountModel: model.elementAt(1)));


      case mapScreen :
        final List data = settings.arguments as List;
        return _cupertinoPageRoute(GoogleMapPage(lng: data.elementAt(0),lat: data.elementAt(1),isUser: data.elementAt(2), userModel: data.elementAt(3),));



      case productDetails :
        final List<dynamic> data = settings.arguments as List<dynamic>;

        return _cupertinoPageRoute(MainProductDetailsScreen(
          userModel: data.elementAt(0) ,
          productModel: data.elementAt(1) ,
          index: data.elementAtOrNull(2) ,
          productState: data.elementAt(3),
          quantity: data.elementAt(4) ,
          total: data.elementAt(5),
          productExist: data.elementAt(6) ,
        ));


      case cartDetails :
        final List<dynamic> data = settings.arguments as List<dynamic>;

        return _cupertinoPageRoute(MainCartDetailsScreen(
            userModel: data.elementAt(0) ,
            cartModel: data.elementAt(1) ,
            totalAndCountModel: data.elementAt(2) ,
            index: data.elementAtOrNull(3) ,
            cartState: data.elementAt(4),
        ));


    // case updateItem :
      //   final List data = settings.arguments as List;
      //   return _cupertinoPageRoute(MainUpdateHomeScreen(
      //     index: data.elementAt(0),
      //     model: data.elementAt(1) ,
      //   ));

      // case createItem : return _materialPageRoute(const MainCreateItemScreen());
      //

    }
    return null;
  }

}