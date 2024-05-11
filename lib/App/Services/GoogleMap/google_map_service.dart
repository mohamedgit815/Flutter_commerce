import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapService {


  Future<List<Placemark>> getGeoCoding(LatLng latLng) async {
    final List<Placemark> placeMarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    return placeMarks;
  }

}