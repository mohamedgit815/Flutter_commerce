import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Category/init_category.dart';
import 'package:commerce/Screens/Category/mobile_category_page.dart';
import 'package:flutter/material.dart';


class MainCategoryScreen extends StatefulWidget {
  const MainCategoryScreen ({Key? key}) : super(key: key);

  @override
  State<MainCategoryScreen> createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {

  late InitCategory initCategory;


  @override
  void initState() {
    super.initState();
    initCategory = InitCategory();
  }


  @override
  Widget build(BuildContext context) {
    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileCategoryPage(init: initCategory) ,
        tablet: null ,
        deskTop: null
    );
  }
}
