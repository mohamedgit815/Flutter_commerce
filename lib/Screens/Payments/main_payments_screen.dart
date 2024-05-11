import 'package:commerce/App/app.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Payments/init_payments.dart';
import 'package:commerce/Screens/Payments/mobile_payments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainPaymentsScreen extends ConsumerStatefulWidget {
  final TotalAndCountModel totalAndCountModel;
  final UserModel userModel;
  const MainPaymentsScreen({Key? key, required this.totalAndCountModel , required this.userModel}) : super(key: key);

  @override
  ConsumerState<MainPaymentsScreen> createState() => _MainPaymentsScreenState();
}

class _MainPaymentsScreenState extends ConsumerState<MainPaymentsScreen> {

  late InitPayments state;


  @override
  void initState() {
    super.initState();
    state = InitPayments();
    Future.delayed(Duration.zero,() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     // state.main.controller.elementAt(0).dispose(); /// City
     // state.main.controller.elementAt(1).dispose(); /// Zip
     // state.main.controller.elementAt(2).dispose(); /// Phone
    state.main.controller.dispose();
    state.main.formState.currentState?.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;


    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobilePaymentsPage(
            state: state,
          ref: ref ,
          keyBoard: keyBoard ,
          mediaQ: mediaQ ,
          height: height ,
          isDark: isDark ,
          theme: theme ,
          connected: false,
          totalAndCountModel: widget.totalAndCountModel ,
          userModel: widget.userModel ,
        ) ,
        tablet: null ,
        deskTop: null
    );
  }
}
