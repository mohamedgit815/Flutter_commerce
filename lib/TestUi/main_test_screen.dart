import 'package:commerce/App/app.dart';
import 'package:commerce/TestUi/init_test.dart';
import 'package:commerce/TestUi/mobile_test_page.dart';
import 'package:flutter/material.dart';


class MainTestScreen extends StatefulWidget {
  const MainTestScreen ({Key? key}) : super(key: key);

  @override
  State<MainTestScreen> createState() => _MainTestScreenState();
}

class _MainTestScreenState extends State<MainTestScreen> {

  late InitTest initTest;


  @override
  void initState() {
    super.initState();
    initTest = InitTest();
  }


  @override
  Widget build(BuildContext context) {
    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileTestPage(init: initTest) ,
        tablet: null ,
        deskTop: null
    );
  }
}
