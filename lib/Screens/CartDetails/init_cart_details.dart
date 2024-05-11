import 'package:commerce/Screens/CartDetails/main_cart_details_state.dart';
import 'package:commerce/Screens/CartDetails/mobile_cart_details_widgets.dart';
import 'package:commerce/Screens/CartDetails/tablet_cart_details_widgets.dart';
import 'package:commerce/Screens/CartDetails/web_cart_details_widgets.dart';



class InitCartDetails {
  final BaseCartDetailsState main = CartDetailsState();
  final BaseMobileCartDetailsWidgets mobile = MobileCartDetailsWidgets();
  final BaseTabletCartDetailsWidgets tablet = TabletCartDetailsWidgets();
  final BaseWebCartDetailsWidgets web = WebCartDetailsWidgets();
}