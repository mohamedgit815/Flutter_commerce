import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/SelectLocation/init_select_location.dart';
import 'package:commerce/Screens/SelectLocation/mobile_select_location_page.dart';
import 'package:flutter/material.dart';


class MainSelectLocationScreen extends StatefulWidget {
  final double lat,long;
  const MainSelectLocationScreen ({Key? key, required this.lat, required this.long}) : super(key: key);

  @override
  State<MainSelectLocationScreen> createState() => _MainSelectLocationScreenState();
}

class _MainSelectLocationScreenState extends State<MainSelectLocationScreen> {

  late InitSelectLocation initSelectLocation;


  @override
  void initState() {
    super.initState();
    initSelectLocation = InitSelectLocation();
    initSelectLocation.main.initCameraPosition(
        latitude: widget.lat ,
        longitude: widget.long
    );
  }


  @override
  Widget build(BuildContext context) {
    return App.packageWidgets.responsiveBuilderScreen(
        mobile: MobileSelectLocationPage(state: initSelectLocation) ,
        tablet: null ,
        deskTop: null
    );
  }
}
