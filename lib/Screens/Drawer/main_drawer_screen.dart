import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Drawer/init_drawer.dart';
import 'package:commerce/Screens/Drawer/mobile_drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainDrawerScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const MainDrawerScreen ({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<MainDrawerScreen> createState() => _MainDrawerScreenState();
}

class _MainDrawerScreenState extends ConsumerState<MainDrawerScreen> {

  late InitDrawer init;


  @override
  void initState() {
    super.initState();
    init = InitDrawer();
  }


  @override
  Widget build(BuildContext context) {

    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileDrawerPage(
            state: init ,
            user: widget.user ,
            ref: ref ,
        ) ,
        tablet: null ,
        deskTop: null
    );
  }
}
