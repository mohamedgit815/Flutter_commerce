import 'package:commerce/Screens/Drawer/main_drawer_state.dart';
import 'package:commerce/Screens/Drawer/mobile_drawer_widgets.dart';
import 'package:commerce/Screens/Drawer/tablet_drawer_widgets.dart';
import 'package:commerce/Screens/Drawer/web_drawer_widgets.dart';


class InitDrawer {
  final BaseDrawerState main = DrawerState();
  final BaseMobileDrawerWidgets mobile = MobileDrawerWidgets();
  final BaseTabletDrawerWidgets tablet = TabletDrawerWidgets();
  final BaseWebDrawerWidgets web = WebDrawerWidgets();
}