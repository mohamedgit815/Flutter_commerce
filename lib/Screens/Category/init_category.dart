import 'package:commerce/Screens/Category/main_category_state.dart';
import 'package:commerce/Screens/Category/mobile_category_widgets.dart';
import 'package:commerce/Screens/Category/tablet_category_widgets.dart';
import 'package:commerce/Screens/Category/web_category_widgets.dart';


class InitCategory {
  final BaseCategoryState main = CategoryState();
  final BaseMobileCategoryWidgets mobile = MobileCategoryWidgets();
  final BaseTabletCategoryWidgets tablet = TabletCategoryWidgets();
  final BaseWebCategoryWidgets web = WebCategoryWidgets();
}