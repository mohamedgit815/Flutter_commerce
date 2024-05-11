import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Admin_Orders/init_admin_orders.dart';
import 'package:commerce/Screens/Admin_Orders/mobile_admin_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainAdminOrdersScreen extends ConsumerStatefulWidget {
  final UserModel userModel;
  const MainAdminOrdersScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  ConsumerState<MainAdminOrdersScreen> createState() => _MainAdminOrdersScreenState();
}

class _MainAdminOrdersScreenState extends ConsumerState<MainAdminOrdersScreen> {

  late InitAdminOrders state;


  @override
  void initState() {
    super.initState();
    state = InitAdminOrders();

    Future.delayed(Duration.zero, () async {
      if(ref.read(state.main.fetchOrderData()).dataList.isEmpty) {
        await state.main.fetchAdminOrders(
            ref: ref,
            userModel: widget.userModel
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.main.scrollController.dispose();
    state.main.disposeFetchCartData(ref: ref, userModel: widget.userModel);
  }



  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;


    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileAdminOrdersPage(
            state: state,
          ref: ref ,
          keyBoard: keyBoard ,
          mediaQ: mediaQ ,
          height: height ,
          isDark: isDark ,
          theme: theme ,
          connected: false ,
          userModel: widget.userModel ,
        ) ,
        tablet: null ,
        deskTop: null
    );
  }
}
