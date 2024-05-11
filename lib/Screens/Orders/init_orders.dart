import 'package:commerce/Screens/Orders/main_orders_state.dart';
import 'package:commerce/Screens/Orders/mobile_orders_widgets.dart';
import 'package:commerce/Screens/Orders/tablet_orders_widgets.dart';
import 'package:commerce/Screens/Orders/web_orders_widgets.dart';


class InitOrders {
  final BaseOrdersState main = OrdersState();
  final BaseMobileOrdersWidgets mobile = MobileOrdersWidgets();
  final BaseTabletOrdersWidgets tablet = TabletOrdersWidgets();
  final BaseWebOrdersWidgets web = WebOrdersWidgets();
}