import 'package:commerce/Screens/Products/main_products_state.dart';
import 'package:commerce/Screens/Products/mobile_products_widgets.dart';
import 'package:commerce/Screens/Products/tablet_products_widgets.dart';
import 'package:commerce/Screens/Products/web_products_widgets.dart';


class InitProducts {
  final BaseProductState main = ProductState();
  final BaseFetchProductData mainAllProduct = AllProductState();
  final BaseFetchProductData mainFashion = ProductFashionState();
  final BaseFetchProductData mainTech = ProductTechState();
  final BaseFetchProductData mainHealth = ProductHealthState();
  final BaseMobileProductsWidgets mobile = MobileProductsWidgets();
  final BaseTabletProductsWidgets tablet = TabletProductsWidgets();
  final BaseWebProductsWidgets web = WebProductsWidgets();
}