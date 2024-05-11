import 'package:commerce/TestUi/main_test_state.dart';
import 'package:commerce/TestUi/mobile_test_widgets.dart';
import 'package:commerce/TestUi/tablet_test_widgets.dart';
import 'package:commerce/TestUi/web_test_widgets.dart';


class InitTest {
  final BaseTestState main = TestState();
  final BaseMobileTestWidgets mobile = MobileTestWidgets();
  final BaseTabletTestWidgets tablet = TabletTestWidgets();
  final BaseWebTestWidgets web = WebTestWidgets();
}