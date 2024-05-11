import 'package:commerce/App/app.dart';
import 'package:commerce/Model/product_details_model.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/ProductDetails/init_product_details.dart';
import 'package:commerce/Screens/ProductDetails/mobile_product_details_page.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainProductDetailsScreen extends ConsumerStatefulWidget {
  final BaseProductModel productModel;
  final UserModel userModel;
  final int index;
  final InitProducts productState;
  final int quantity, total;
  final bool productExist;

  const MainProductDetailsScreen({
    Key? key ,
    required this.productModel ,
    required this.userModel ,
    required this.index ,
    required this.productState ,
    required this.total ,
    required this.quantity ,
    required this.productExist ,
  }) : super(key: key);

  @override
  ConsumerState<MainProductDetailsScreen> createState() => _MainProductDetailsScreenState();
}

class _MainProductDetailsScreenState extends ConsumerState<MainProductDetailsScreen> {

  late InitProductDetails initProductDetails;


  @override
  void initState() {
    super.initState();
    initProductDetails = InitProductDetails();


    Future.delayed(Duration.zero,() async {
      await initProductDetails.main.fetchProductDetails(
          ref: ref ,
          model: widget.productModel ,
          userModel: widget.userModel ,
          quantity: widget.quantity ,
          total: widget.total ,
          productExist: widget.productExist
      );
    });

  }


  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, prov, _) {
        final BaseProductDetailsModel model = initProductDetails.main.getProductDetails(refProv: prov);

        if(ref.read(initProductDetails.main.fetchProductDetailsProv).dataList.isEmpty) {
          return App.globalWidgets.loadingWidget(parent: true);
        } else {
          return App.packageWidgets.responsiveBuilderScreen(
              mobile: MobileProductDetailsPage(
                  state: initProductDetails ,
                  userModel: widget.userModel ,
                  ref: ref ,
                  index: widget.index ,
                  productState: widget.productState ,
                  productModel: widget.productModel ,
                  model: model
              ) ,
              tablet: null ,
              deskTop: null
          );
        }
      }
    );
  }
}
