import 'package:commerce/Screens/BottomBar/main_bottom_bar_state.dart';
import 'package:commerce/Screens/BottomBar/mobile_bottom_bar_widgets.dart';
import 'package:commerce/Screens/BottomBar/tablet_bottom_bar_widgets.dart';
import 'package:commerce/Screens/BottomBar/web_bottom_bar_widgets.dart';


class InitBottomBar {
  final BaseBottomBarState main = BottomBarState();
  final BaseMobileBottomBarWidgets mobile = MobileBottomBarWidgets();
  final BaseTabletBottomBarWidgets tablet = TabletBottomBarWidgets();
  final BaseWebBottomBarWidgets web = WebBottomBarWidgets();
}