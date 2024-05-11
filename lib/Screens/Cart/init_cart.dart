import 'package:commerce/Screens/Cart/main_cart_state.dart';
import 'package:commerce/Screens/Cart/mobile_cart_widgets.dart';
import 'package:commerce/Screens/Cart/tablet_cart_widgets.dart';
import 'package:commerce/Screens/Cart/web_cart_widgets.dart';


class InitCart {
  final BaseCartState main = CartState();
  final BaseMobileCartWidgets mobile = MobileCartWidgets();
  final BaseTabletCartWidgets tablet = TabletCartWidgets();
  final BaseWebCartWidgets web = WebCartWidgets();
}