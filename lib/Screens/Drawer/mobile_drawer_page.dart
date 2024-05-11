import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Drawer/init_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileDrawerPage extends StatelessWidget  {
  final InitDrawer state;
  final UserModel user;
  final WidgetRef ref;

  const MobileDrawerPage({
    Key? key ,
    required this.state ,
    required this.user ,
    required this.ref
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: App.theme.conditionTheme(
          context: context,
          light: App.color.helperWhite, dark: App.color.darkSecond),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: App.theme.conditionTheme(
                    context: context,
                    light: App.color.lightMain,
                    dark: App.color.darkMain
                ),
              ),
              accountName: App.text.text(
                user.name.toString(), context,
                color: App.color.helperWhite
              ),

              accountEmail: App.text.text(
                  user.email.toString(), context ,
                color: App.color.helperWhite
              )
          ),

          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return Column(
                  children: [
                    Consumer(
                        builder: (context, prov, _) {
                          return SwitchListTile.adaptive(
                              title: App.text.translateText(!prov.watch(App.theme.themeProvider).darkTheme ?LangEnum.dark.name:LangEnum.light.name, context),
                              value: prov.read(App.theme.themeProvider).darkTheme ,
                              onChanged: (v) {
                                prov.read(App.theme.themeProvider).toggleTheme();
                              }
                          );
                        }
                    ) ,


                    Consumer(
                        builder: (context, prov, _) {
                          return SubmenuButton(
                            menuChildren: [
                              App.buttons.elevated(
                                  onPressed: () {
                                    ref.read(App.localization.provLang).toggleLang(LangEnum.en.name);
                                  },
                                  size: Size(constraints.maxWidth * 1.0,constraints.maxHeight * 0.1),
                                  child:App.text.translateText(LangEnum.en.name, context,color: App.color.whiteOne)
                              ) ,

                              App.buttons.elevated(
                                  onPressed: () {
                                    ref.read(App.localization.provLang).toggleLang(LangEnum.ar.name);
                                  },
                                  size: Size(constraints.maxWidth * 1.0,constraints.maxHeight * 0.1),
                                  child:App.text.translateText(LangEnum.ar.name, context,color: App.color.whiteOne)
                              ) ,

                              App.buttons.elevated(
                                  onPressed: () {
                                    ref.read(App.localization.provLang).toggleLang(LangEnum.es.name);
                                  },
                                  size: Size(constraints.maxWidth * 1.0,constraints.maxHeight * 0.1),
                                  child:App.text.translateText(LangEnum.es.name, context,color: App.color.whiteOne)
                              ) ,
                            ] ,
                            leadingIcon: const Icon(Icons.language_outlined),
                            style: ButtonStyle(
                              minimumSize: MaterialStatePropertyAll(Size(constraints.maxWidth * 1.0,constraints.maxHeight * 0.1)),
                            ),
                            child: App.text.translateText(
                                LangEnum.lang.name, context ,
                                color: App.color.helperWhite
                            ) ,
                          );
                        }
                    ) ,


                    Divider(color: App.color.whiteOne),


                    App.buttons.text(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteGenerators.orderScreen,arguments: user);
                        },
                        backGroundColor: App.theme.conditionTheme(
                            context: context,
                            light: App.color.lightMain, dark: App.color.darkFirst),
                        size: Size(constraints.maxWidth * 1.0,constraints.maxHeight * 0.1),
                        child: App.text.text("Orders", context,fontSize: 17.0,color: App.color.whiteOne)
                    ) ,


                    Visibility(
                      child: App.buttons.text(
                          onPressed: () {
                            Navigator.of(context).pushNamed(RouteGenerators.adminOrderScreen,arguments: user);
                          },
                          backGroundColor: App.theme.conditionTheme(
                              context: context,
                              light: App.color.lightMain, dark: App.color.darkFirst),
                          size: Size(constraints.maxWidth * 1.0,constraints.maxHeight * 0.1),
                          child: App.text.text("Admin Orders", context,fontSize: 17.0,color: App.color.whiteOne)
                      ),
                    ) ,
                  ],
                );
              }
            ),
          )

        ],
      ),
    );
  }
}
