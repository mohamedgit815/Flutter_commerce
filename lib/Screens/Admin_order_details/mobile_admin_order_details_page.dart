import 'package:commerce/Screens/Admin_order_details/init_admin_order_details.dart';
import 'package:flutter/material.dart';


class MobileAdminOrdersDetailsPage extends StatefulWidget  {
  final InitAdminOrdersDetails init;

  const MobileAdminOrdersDetailsPage({Key? key , required this.init}) : super(key: key);

  @override
  State<MobileAdminOrdersDetailsPage> createState() => _MobileAdminOrdersDetailsPageState();
}

class _MobileAdminOrdersDetailsPageState extends State<MobileAdminOrdersDetailsPage> {



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [

        ],
      ),
    );
  }
}
