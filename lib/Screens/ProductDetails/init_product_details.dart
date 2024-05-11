import 'package:commerce/Screens/ProductDetails/main_product_details_state.dart';
import 'package:commerce/Screens/ProductDetails/mobile_product_details_widgets.dart';
import 'package:commerce/Screens/ProductDetails/tablet_product_details_widgets.dart';
import 'package:commerce/Screens/ProductDetails/web_product_details_widgets.dart';


class InitProductDetails {
  final BaseProductDetailsState main = ProductDetailsState();
  final BaseMobileProductDetailsWidgets mobile = MobileProductDetailsWidgets();
  final BaseTabletProductDetailsWidgets tablet = TabletProductDetailsWidgets();
  final BaseWebProductDetailsWidgets web = WebProductDetailsWidgets();
}