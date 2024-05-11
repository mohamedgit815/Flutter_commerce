import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Authentication/Login/init_login.dart';
import 'package:commerce/Screens/Authentication/Login/mobile_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MainLoginScreen extends ConsumerStatefulWidget {
  final SharedPreferences preferences;
  final UserModel userModel;

  const MainLoginScreen ({
    Key? key ,
    required this.userModel ,
    required this.preferences
  }) : super(key: key);

  @override
  ConsumerState<MainLoginScreen> createState() => _MainLoginScreenState();
}

class _MainLoginScreenState extends ConsumerState<MainLoginScreen> {

  late InitLogin state;

  @override
  void initState() {
    super.initState();
    state = InitLogin();
    Future.delayed(Duration.zero,() async {
      await App.fcm.subscribeTopic(topic: GeneralEnum.commerce.name);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.main.controller.elementAt(0).dispose(); /// Email
    state.main.controller.elementAt(1).dispose(); /// Password
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    App.fcm.getInitBackgroundMessage(context: context, message: "Google");
  }


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileLoginPage(
            state: state ,
            ref: ref ,
            keyBoard: keyBoard ,
            mediaQ: mediaQ ,
            height: height ,
            isDark: isDark ,
            theme: theme ,
            connected: false ,
            preferences: widget.preferences,
            userModel: widget.userModel
        ) ,
        tablet: null ,
        deskTop: null
    );
  }
}
