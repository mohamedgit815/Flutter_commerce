import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Admin_order_details/init_admin_order_details.dart';
import 'package:commerce/Screens/Admin_order_details/mobile_admin_order_details_page.dart';
import 'package:flutter/material.dart';


class MainAdminOrdersDetailsScreen extends StatefulWidget {
  const MainAdminOrdersDetailsScreen ({Key? key}) : super(key: key);

  @override
  State<MainAdminOrdersDetailsScreen> createState() => _MainAdminOrdersDetailsScreenState();
}

class _MainAdminOrdersDetailsScreenState extends State<MainAdminOrdersDetailsScreen> {

  late InitAdminOrdersDetails initAdminOrdersDetails;


  @override
  void initState() {
    super.initState();
    initAdminOrdersDetails = InitAdminOrdersDetails();
  }


  @override
  Widget build(BuildContext context) {
    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileAdminOrdersDetailsPage(init: initAdminOrdersDetails) ,
        tablet: null ,
        deskTop: null
    );
  }
}
