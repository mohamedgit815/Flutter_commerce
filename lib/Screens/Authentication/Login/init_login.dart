import 'package:commerce/Screens/Authentication/Login/main_login_state.dart';
import 'package:commerce/Screens/Authentication/Login/mobile_login_widgets.dart';
import 'package:commerce/Screens/Authentication/Login/tablet_login_widgets.dart';
import 'package:commerce/Screens/Authentication/Login/web_login_widgets.dart';


class InitLogin {
  final BaseLoginState main = LoginState();
  final BaseMobileLoginWidgets mobile = MobileLoginWidgets();
  final BaseTabletLoginWidgets tablet = TabletLoginWidgets();
  final BaseWebLoginWidgets web = WebLoginWidgets();
}