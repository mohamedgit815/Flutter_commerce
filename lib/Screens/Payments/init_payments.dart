


import 'package:commerce/Screens/Payments/main_payments_state.dart';
import 'package:commerce/Screens/Payments/mobile_payments_widgets.dart';
import 'package:commerce/Screens/Payments/tablet_payments_widgets.dart';
import 'package:commerce/Screens/Payments/web_payments_widgets.dart';

class InitPayments {
  final BasePaymentsState main = PaymentsState();
  final BaseMobilePaymentsWidgets mobile = MobilePaymentsWidgets();
  final BaseTabletPaymentsWidgets tablet = TabletPaymentsWidgets();
  final BaseWebPaymentsWidgets web = WebPaymentsWidgets();
}