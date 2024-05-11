import 'package:commerce/Screens/Admin_Orders/main_admin_orders_state.dart';
import 'package:commerce/Screens/Admin_Orders/mobile_admin_orders_widgets.dart';
import 'package:commerce/Screens/Admin_Orders/tablet_admin_orders_widgets.dart';
import 'package:commerce/Screens/Admin_Orders/web_admin_orders_widgets.dart';



class InitAdminOrders {
  final BaseAdminOrdersState main = AdminOrdersState();
  final BaseMobileAdminOrdersWidgets mobile = MobileAdminOrdersWidgets();
  final BaseTabletAdminOrdersWidgets tablet = TabletAdminOrdersWidgets();
  final BaseWebAdminOrdersWidgets web = WebAdminOrdersWidgets();
}