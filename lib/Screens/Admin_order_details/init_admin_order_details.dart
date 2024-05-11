import 'package:commerce/Screens/Admin_order_details/main_admin_order_details_state.dart';
import 'package:commerce/Screens/Admin_order_details/mobile_admin_order_details_widgets.dart';
import 'package:commerce/Screens/Admin_order_details/tablet_admin_order_details_widgets.dart';
import 'package:commerce/Screens/Admin_order_details/web_admin_order_details_widgets.dart';


class InitAdminOrdersDetails {
  final BaseAdminOrdersDetailsState main = AdminOrdersDetailsState();
  final BaseMobileAdminOrdersDetailsWidgets mobile = MobileAdminOrdersDetailsWidgets();
  final BaseTabletAdminOrdersDetailsWidgets tablet = TabletAdminOrdersDetailsWidgets();
  final BaseWebAdminOrdersDetailsWidgets web = WebAdminOrdersDetailsWidgets();
}