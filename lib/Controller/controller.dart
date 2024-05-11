import 'package:commerce/Controller/auth_controller.dart';
import 'package:commerce/Controller/cart_controller.dart';
import 'package:commerce/Controller/order_controller.dart';
import 'package:commerce/Controller/product_controller.dart';

class Controller {

  static final BaseCartController cart = CartController();
  static final BaseOrderController order = OrderController();
  static final BaseAuthController auth = AuthController();
  static final BaseProductController product = ProductController();

  Object authController() {
    return BaseAuthController;
  }

}