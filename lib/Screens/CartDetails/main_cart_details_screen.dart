import 'package:commerce/App/app.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Model/total_and_count_model.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Cart/init_cart.dart';
import 'package:commerce/Screens/CartDetails/init_cart_details.dart';
import 'package:commerce/Screens/CartDetails/mobile_cart_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainCartDetailsScreen extends ConsumerStatefulWidget {
  final BaseCartModel cartModel;
  final UserModel userModel;
  final int index ;
  final InitCart cartState;
  final TotalAndCountModel totalAndCountModel;

  const MainCartDetailsScreen ({
    Key? key,
    required this.cartState ,
    required this.cartModel ,
    required this.userModel ,
    required this.totalAndCountModel ,
    required this.index ,
  }) : super(key: key);

  @override
  ConsumerState<MainCartDetailsScreen> createState() => _MainCartDetailsScreenState();
}

class _MainCartDetailsScreenState extends ConsumerState<MainCartDetailsScreen> {

  late InitCartDetails initCartDetails;

  @override
  void initState() {
    super.initState();
    initCartDetails = InitCartDetails();

    Future.delayed(Duration.zero,() async {
      await initCartDetails.main.fetchCartDetails(
          ref: ref ,
          model: widget.cartModel ,
          totalAndCountModel: widget.totalAndCountModel
      );
    });



  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, prov, _) {
        final (BaseCartModel, TotalAndCountModel) model = initCartDetails.main.getCartDetails(ref: prov);

        if(prov.read(initCartDetails.main.fetchCartCartDetailsProv).dataList.isEmpty) {
          return App.globalWidgets.loadingWidget(parent: true);
        } else {
          return App.packageWidgets.responsiveBuilderScreen(
              mobile: MobileCartDetailsPage(
                  userModel: widget.userModel ,
                  ref: ref ,
                  state: initCartDetails ,
                  index: widget.index ,
                  cartState: widget.cartState ,
                  cartModel: widget.cartModel ,
                  model: model.$1,
                  totalAndCountModel: model.$2

              ) ,

              tablet: null ,

              deskTop: null
          );
        }
      }
    );
  }
}
