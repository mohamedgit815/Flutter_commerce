import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/BottomBar/init_bottom_bar.dart';
import 'package:commerce/Screens/Drawer/main_drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileBottomBarPage extends StatelessWidget  {
  final InitBottomBar state;
  final WidgetRef ref;
  final bool keyBoard , connected;
  final double height;
  final MediaQueryData mediaQ;
  final ThemeData theme;
  final bool isDark;
  final UserModel user;

  const MobileBottomBarPage({Key? key ,
    required this.state ,
    required this.user ,
    required this.ref ,
    required this.keyBoard ,
    required this.connected ,
    required this.height ,
    required this.mediaQ ,
    required this.isDark ,
    required this.theme
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: MainDrawerScreen(user: user) ,


      bottomNavigationBar: Consumer(
        builder: (context,prov,_) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [

              BottomNavigationBarItem(icon: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(Icons.home_outlined)), label: '${App.localization.translate(context: context, text: LangEnum.home.name)}') ,
              BottomNavigationBarItem(icon: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(Icons.add_shopping_cart_outlined)), label: '${App.localization.translate(context: context, text: LangEnum.cart.name)}') ,

            ],
            currentIndex: prov.watch(state.main.bottomProv).integer ,
            onTap: (int v) {
              prov.read(state.main.bottomProv).equalValueInteger(v);
            },
          );
        }
      ) ,


      body: Consumer(
          builder: (context, prov,_) {
            return Stack(
                children: prov.read(state.main.bottomProv).pages(userModel: user).asMap()
                    .map((i, screen) => MapEntry(i,
                    Offstage(offstage: prov.watch(state.main.bottomProv).integer != i,child: screen,)))
                    .values.toList()
            );
          }
      ),


    );
  }
}
