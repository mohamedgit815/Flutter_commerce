import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:commerce/Screens/Products/mobile_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainProductsScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const MainProductsScreen ({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<MainProductsScreen> createState() => _MainProductsScreenState();
}

class _MainProductsScreenState extends ConsumerState<MainProductsScreen> {

  late InitProducts init;


  @override
  void initState() {
    super.initState();

    init = InitProducts();

    Future.delayed(Duration.zero,() async {
      await init.mainAllProduct.initFetchProductData(ref: ref );

      await init.mainFashion.initFetchProductData(ref: ref);

      await init.mainTech.initFetchProductData(ref: ref);

      await init.mainHealth.initFetchProductData(ref: ref);

    });



  }


  @override
  void dispose() {
    super.dispose();
    init.mainAllProduct.scrollController.dispose();
    init.mainAllProduct.disposeFetchProductData(ref: ref );

    init.mainFashion.scrollController.dispose();
    init.mainFashion.disposeFetchProductData(ref: ref);

    init.mainTech.scrollController.dispose();
    init.mainTech.disposeFetchProductData(ref: ref);


    init.mainHealth.scrollController.dispose();
    init.mainHealth.disposeFetchProductData(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final MediaQueryData mediaQ = MediaQuery.of(context);
    final double height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;


    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileProductsPage(
          state: init ,
          ref: ref ,
          keyBoard: keyBoard ,
          mediaQ: mediaQ ,
          height: height ,
          userModel: widget.user ,
          connected: false
        ) ,


        tablet: null ,
        deskTop: null
    );
  }
}
