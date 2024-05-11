import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Authentication/Register/init_register.dart';
import 'package:commerce/Screens/Authentication/Register/mobile_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainRegisterScreen extends ConsumerStatefulWidget {
  const MainRegisterScreen ({Key? key}) : super(key: key);

  @override
  ConsumerState<MainRegisterScreen> createState() => _MainRegisterScreenState();
}

class _MainRegisterScreenState extends ConsumerState<MainRegisterScreen> {

  late InitRegister state;


  @override
  void initState() {
    super.initState();
    state = InitRegister();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.main.controller.elementAt(0).dispose(); /// Name
    state.main.controller.elementAt(1).dispose(); /// Email
    state.main.controller.elementAt(2).dispose(); /// Password
  }


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileRegisterPage(
            state: state ,
            ref: ref ,
            keyBoard: keyBoard ,
            mediaQ: mediaQ ,
            height: height ,
            isDark: isDark ,
            theme: theme ,
            connected: false ,
        ) ,
        tablet: null ,
        deskTop: null
    );
  }
}
