import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/BottomBar/init_bottom_bar.dart';
import 'package:commerce/Screens/BottomBar/mobile_bottom_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainBottomBarScreen extends ConsumerStatefulWidget {

  final UserModel userModel;

  const MainBottomBarScreen ({
    Key? key ,
    required this.userModel
  }) : super(key: key);

  @override
  ConsumerState<MainBottomBarScreen> createState() => _MainBottomBarScreenState();
}

class _MainBottomBarScreenState extends ConsumerState<MainBottomBarScreen> {

  late InitBottomBar init;


  @override
  void initState() {
    super.initState();
    init = InitBottomBar();
    Future.delayed(Duration.zero,(){
      //App.fcm.receiveOnOpenedMessageApp(context);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //App.fcm.receiveOnOpenedMessageApp(context);
  }


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;


    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileBottomBarPage(
            state: init,
            ref: ref ,
            keyBoard: keyBoard ,
            mediaQ: mediaQ ,
            height: height ,
            isDark: isDark ,
            theme: theme ,
            connected: false,
            user: widget.userModel ,
        ) ,
        tablet: null ,
        deskTop: null
    );
  }
}
