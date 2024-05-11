class PlacesModel {
  final double coorLat, coorLng;
  final String name, country, countryCode;
  final String? district;

  PlacesModel({
    required this.coorLat ,
    required this.coorLng ,
    required this.name ,
    required this.country ,
    required this.countryCode ,
    required this.district
  });

  factory PlacesModel.fromJson(Map<String,dynamic>json) {
    return PlacesModel(
        coorLat: json['geometry']['coordinates'][0] ,
        coorLng: json['geometry']['coordinates'][1] ,
        name: json['properties']['name'] ,
        country: json['properties']['country'] ,
        countryCode: json['properties']['countrycode'] ,
        district: json['properties']['district']
    );
  }
}