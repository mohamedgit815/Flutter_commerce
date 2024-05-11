import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Cart/init_cart.dart';
import 'package:commerce/Screens/Cart/mobile_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainCartScreen extends ConsumerStatefulWidget {
  final UserModel userModel;

  const MainCartScreen ({Key? key, required this.userModel}) : super(key: key);

  @override
  ConsumerState<MainCartScreen> createState() => _MainCartScreenState();
}

class _MainCartScreenState extends ConsumerState<MainCartScreen> {

  late InitCart initCart;


  @override
  void initState() {
    super.initState();
    initCart = InitCart();

    Future.delayed(Duration.zero, () async {
      await initCart.main.initFetchCartData(
          ref: ref,
          userModel: widget.userModel
      );

      await initCart.main.addTotalAndCount(
          ref: ref,
          userModel: widget.userModel
      );
    }
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    initCart.main.scrollCartController.dispose();
    initCart.main.disposeFetchCartData(ref: ref, userModel: widget.userModel);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;


    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileCartPage(
          state: initCart ,
          ref: ref ,
          keyBoard: keyBoard ,
          mediaQ: mediaQ ,
          height: height ,
          isDark: isDark ,
          theme: theme ,
          connected: false ,
          userModel: widget.userModel,
        ) ,
        tablet: null ,
        deskTop: null
    );

  }
}
