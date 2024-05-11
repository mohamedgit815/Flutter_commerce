import 'package:commerce/App/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseMobileCartWidgets {

  Widget buildMyCartText({
    required BuildContext context
  });


  Widget buildCartWidget({
    required BoxConstraints constraints
  });


  Widget buildOrderInfoText({required BuildContext context});


  Widget buildOrderInformationWidget({
    required BuildContext context ,
    required BoxConstraints constraints
  });


  Widget buildCheckOutButton({
    required BuildContext context ,
    required VoidCallback onPressed
  });

}











class MobileCartWidgets implements BaseMobileCartWidgets {

  @override
  SliverToBoxAdapter buildMyCartText({
    required BuildContext context
}) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            children: [

              const Expanded(
                flex: 3,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: DrawerButton()
                  )
              ) ,

              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0) ,
                  child: App.text.text(
                      'My Cart' , context ,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ) ,

          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: App.text.text(
                '8 Items' , context ,
                fontSize: 12.0,
              )),
        ],
      ) ,);
  }


  @override
  Widget buildCartWidget({
    required BoxConstraints constraints
}) {
    return Consumer(
      builder: (context, prov, _) {
        return SliverList.builder(
            itemCount: 8 ,
            itemBuilder: (context,i) {
              return Container(
                width: double.infinity ,
                height: constraints.maxHeight * 0.2 ,
                padding: const EdgeInsets.all(1.0) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: App.theme.conditionTheme(
                      context: context,
                      light: App.color.helperWhite,
                      dark: App.color.darkFirst
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0 ,
                    vertical: 10.0
                ) ,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Image.asset(
                            'assets/images/google.png' ,
                            fit: BoxFit.cover,
                          ),
                        )
                    ) ,


                    Expanded(
                        flex: 2,
                        child: App.text.text(
                          'dskldhfljkdshgflkjdshgfsdfsfajkshfkjahsfkjahkfshasjkfhakshjkdhaskjdhashdja111111111111' ,
                          context ,
                          maxLine: 12 ,
                        )

                    ) ,


                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Expanded(
                                  child: CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: App.theme.conditionTheme(
                                        context: context,
                                        light: App.color.lightMain ,
                                        dark: App.color.darkMain
                                    ),
                                    child: App.buttons.icon(
                                        onPressed: () {} ,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0
                                          ),
                                          child: Icon(
                                            Icons.minimize_sharp ,
                                            color: App.color.helperWhite ,
                                            size: 12.0,
                                          ),
                                        )
                                    ),
                                  )
                              ) ,

                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(bottom: 5.0),
                                      alignment: Alignment.bottomCenter,
                                      child: App.text.text(
                                        '1' , context ,
                                        fontSize: 14.0 ,
                                      )
                                  )
                              ) ,

                              Expanded(
                                  child: CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: App.theme.conditionTheme(
                                        context: context,
                                        light: App.color.lightMain ,
                                        dark: App.color.darkMain
                                    ),
                                    child: App.buttons.icon(onPressed: (){},
                                        icon: Icon(
                                          Icons.add ,
                                          color: App.color.helperWhite,
                                          size: 12.0,
                                        )
                                    ),
                                  )
                              )

                            ],
                          ),
                        ))
                  ],
                ),
              );
            });
      }
    );
  }


  @override
  SliverToBoxAdapter buildOrderInfoText({
    required BuildContext context
  }) {
    return SliverToBoxAdapter(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
          alignment: Alignment.centerLeft,
          child: App.text.text(
              'Order Info' , context ,
              fontSize: 12.0,
              color: App.color.helperBlack ,
              fontWeight: FontWeight.bold
          )),
    );
  }



  @override
  SliverToBoxAdapter buildOrderInformationWidget({
    required BuildContext context ,
    required BoxConstraints constraints
}) {
    return SliverToBoxAdapter(
        child: Container(
          height: constraints.maxHeight * 0.25,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: App.theme.conditionTheme(
                  context: context,
                  light: App.color.helperWhite ,
                  dark: App.color.darkFirst
              ) ,
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [
                      App.text.text("SubTotal",context ),
                      App.text.text("60", context ),
                    ],
                  ),
                ),
              ) ,


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [
                      App.text.text("Delivery",context),
                      App.text.text("4",context),
                    ],
                  ),
                ),
              ) ,


              Expanded(
                  child: App.globalWidgets.expanded(
                      child: const Divider()
                  )
              ) ,


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [
                      App.text.text("Total",context),
                      App.text.text("64",context),
                    ],
                  ),
                ),
              ) ,
            ],
          ),
        )
    );
  }



  @override
  SliverToBoxAdapter buildCheckOutButton({
    required BuildContext context ,
    required VoidCallback onPressed
}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: App.globalWidgets.expanded(
          flex: 20 ,
          child: App.buttons.elevated(
              borderRadius: BorderRadius.circular(5.0),
              onPressed: onPressed ,
              child: App.text.text(
                  "CheckOut",context ,
                  color: App.color.helperWhite
              )
          ),
        ),
      ),
    );
  }

}