import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Authentication/ChangePw/init_change_pw.dart';
import 'package:commerce/Screens/Authentication/ChangePw/mobile_change_pw_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainChangePwScreen extends ConsumerStatefulWidget {
  const MainChangePwScreen ({Key? key}) : super(key: key);

  @override
  ConsumerState<MainChangePwScreen> createState() => _MainChangePwScreenState();
}

class _MainChangePwScreenState extends ConsumerState<MainChangePwScreen> {

  late InitChangePw state;


  @override
  void initState() {
    super.initState();
    state = InitChangePw();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.main.controller.elementAt(0).dispose(); /// Name
    state.main.controller.elementAt(1).dispose(); /// Old Password
    state.main.controller.elementAt(2).dispose(); /// New Password
    state.main.controller.elementAt(3).dispose(); /// Confirm New Password
  }


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;


    return App.packageWidgets.responsiveBuilderScreen(

        mobile: MobileChangePwPage(
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
