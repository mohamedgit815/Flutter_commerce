
import 'package:commerce/Screens/Authentication/Register/main_register_state.dart';
import 'package:commerce/Screens/Authentication/Register/mobile_register_widgets.dart';
import 'package:commerce/Screens/Authentication/Register/tablet_register_widgets.dart';
import 'package:commerce/Screens/Authentication/Register/web_register_widgets.dart';

class InitRegister {
  final BaseRegisterState main = RegisterState();
  final BaseMobileRegisterWidgets mobile = MobileRegisterWidgets();
  final BaseTabletRegisterWidgets tablet = TabletRegisterWidgets();
  final BaseWebRegisterWidgets web = WebRegisterWidgets();
}