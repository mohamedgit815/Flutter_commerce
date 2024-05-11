import 'package:commerce/Screens/SelectLocation/init_select_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MobileSelectLocationPage extends StatelessWidget  {
  final InitSelectLocation state;

  const MobileSelectLocationPage({Key? key , required this.state}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: state.main.initialCameraPosition ,
          mapType: MapType.terrain ,
          onTap: (LatLng latLng) {

          } ,
      ),
    );
  }
}
