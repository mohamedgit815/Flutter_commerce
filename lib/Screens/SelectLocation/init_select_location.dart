import 'package:commerce/Screens/SelectLocation/main_select_location_state.dart';
import 'package:commerce/Screens/SelectLocation/mobile_select_location_widgets.dart';
import 'package:commerce/Screens/SelectLocation/tablet_select_location_widgets.dart';
import 'web_select_location_widgets.dart';


class InitSelectLocation {
  final BaseSelectLocationState main = SelectLocationState();
  final BaseMobileSelectLocationWidgets mobile = MobileSelectLocationWidgets();
  final BaseTabletSelectLocationWidgets tablet = TabletSelectLocationWidgets();
  final BaseWebSelectLocationWidgets web = WebSelectLocationWidgets();
}