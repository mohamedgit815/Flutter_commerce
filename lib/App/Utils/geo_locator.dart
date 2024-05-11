import 'package:geolocator/geolocator.dart';

abstract class BaseGeoLocatorHelper {
  Future<Position> getCurrentLocation();

  void liveLocation();

  Future<void> openMap({required String lat,required String lang});
}


class GeoLocatorHelper extends BaseGeoLocatorHelper {
  @override
  Future<Position> getCurrentLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled) {
      return Future.error("Location Services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error("Location Services are disabled");
      }
    }

    if(permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are Permanently denied, we cannot request");
    }

    return await Geolocator.getCurrentPosition();
  }


  @override
   void liveLocation() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high ,
      distanceFilter: 100
    );

     Geolocator.getPositionStream(
      locationSettings: locationSettings
    );
  }


  @override
  Future<void> openMap({required String lat,required String lang}) async {
    //final String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lang';
    // await canLaunchUrlString(googleUrl)
    // ? wait launchUrlString(googleUrl)
    // : throw 'Could not launch $googleUrl';
  }
}