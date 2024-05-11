import 'package:commerce/Screens/Authentication/ChangePw/main_change_pw_state.dart';
import 'package:commerce/Screens/Authentication/ChangePw/mobile_change_pw_widgets.dart';
import 'package:commerce/Screens/Authentication/ChangePw/tablet_change_pw_widgets.dart';
import 'package:commerce/Screens/Authentication/ChangePw/web_change_pw_widgets.dart';


class InitChangePw {
  final BaseChangePwState main = ChangePwState();
  final BaseMobileChangePwWidgets mobile = MobileChangePwWidgets();
  final BaseTabletChangePwWidgets tablet = TabletChangePwWidgets();
  final BaseWebChangePwWidgets web = WebChangePwWidgets();
}