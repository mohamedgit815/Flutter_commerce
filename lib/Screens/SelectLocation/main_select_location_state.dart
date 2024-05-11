import 'package:google_maps_flutter/google_maps_flutter.dart';


abstract class BaseSelectLocationState {
  late CameraPosition initialCameraPosition;

  CameraPosition initCameraPosition({
    required double latitude ,
    required double longitude
  });

}

class SelectLocationState extends BaseSelectLocationState {

  @override
  CameraPosition initCameraPosition({
    required double latitude ,
    required double longitude
  }) {
    initialCameraPosition = CameraPosition(target: LatLng(latitude, longitude));
    return initialCameraPosition;
  }


}