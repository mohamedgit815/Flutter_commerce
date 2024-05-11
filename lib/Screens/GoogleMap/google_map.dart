import 'dart:async';
import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/GoogleMap/search_locations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


class GoogleMapPage extends ConsumerStatefulWidget {
  final double lng, lat;
  final bool isUser;
  final UserModel userModel;
  const GoogleMapPage({super.key, required this.lng, required this.lat,required this.isUser,required this.userModel});

  @override
  ConsumerState<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends ConsumerState<GoogleMapPage> with _GoogleMap_ {
  final Completer<GoogleMapController> completer = Completer();
  StreamSubscription<Position>? subscription;
  late GoogleMapController controller;
  CameraPosition? cameraPosition;
  late io.Socket socket;
  final List<dynamic> msgValue = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    socket.dispose();
    socket.close();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final GoogleMapController controller_ = await completer.future;
      controller_.dispose();
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSocket();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
       if(widget.isUser == true ) {
         await initCamera();
       }
    });
   // getNewCurrentlyLocationStream();
    if(widget.isUser == true) {
      getNewCurrentlyLocationStream();
    }
  }

  void initSocket() {
    final Map<String, dynamic> option = <String, dynamic>{
      "transports":['websocket'] ,
      'autoConnect': false
    };


    socket = io.io(App.strings.mainUrl, option).connect();

    socket.on('msg', (data) {
      if(cameraPosition == null) {
        setState(() {});
      }


      if(widget.isUser == false ) {
         final LatLng latLng_ = LatLng(data['lat'], data['lng']);

         getNewCurrentlyLocationStreamForClient(
           latLng: latLng_ ,
           idUser: data['userId']
         );
       }

       msgValue.add(data);
    });

  }

  Future<void> initCamera() async {
    if(cameraPosition == null) {
      setState(() {});
    }

    cameraPosition = CameraPosition(
        target: LatLng(widget.lng,widget.lat),
       // zoom: 14.4746
        zoom: 14.5
    );

    //if(widget.isUser == true) {
      ref.read(mapProv).addMarker(Marker(markerId: MarkerId("${widget.userModel.id}"),position: cameraPosition!.target));
    //}
  }

  Future<void> getMyCurrentLocation() async {
    cameraPosition = CameraPosition(target: LatLng(widget.lat,widget.lng) , zoom: 14.5);
    final GoogleMapController controller_ = await completer.future;
    await controller_.animateCamera(CameraUpdate.newLatLngZoom(cameraPosition!.target,cameraPosition!.zoom));
    ref.read(mapProv).changeMarker(id: "${widget.userModel.id}", latLng: cameraPosition!.target);
  }

  Future<void> getNewLocation(LatLng latLng) async {
    cameraPosition = CameraPosition(target: latLng , zoom: 14.5);
    final GoogleMapController controller_ = await completer.future;
    //await controller_.animateCamera(CameraUpdate.newLatLng(cameraPosition!.target));
    await controller_.animateCamera(CameraUpdate.newLatLngZoom(cameraPosition!.target,cameraPosition!.zoom));
    //await controller_.animateCamera(CameraUpdate.newCameraPosition(cameraPosition!));
    ref.read(mapProv).changeMarker(id: "${widget.userModel.id}", latLng: cameraPosition!.target);
  }

  void getNewCurrentlyLocationStream() async {
    subscription = Geolocator.getPositionStream().listen((event) async {
      print("${event.latitude} ${event.longitude}");

      final LatLng latLng_ = LatLng(event.latitude, event.longitude);


      await getNewLocation(latLng_);

        if(widget.isUser == true) {
          final Map<String,dynamic> data = <String,dynamic>{
            "userId": widget.userModel.id.toString() ,
            "lat": event.latitude ,
            "lng": event.longitude
          };

          socket.emit("msg", data);
        }




        ref.read(mapProv).changeMarker(
            id: "${widget.userModel.id}"  ,
            latLng: latLng_
        );

    });
  }

  void getNewCurrentlyLocationStreamForClient({
    required LatLng latLng ,
    required String idUser
  }) async {

    cameraPosition = CameraPosition(
        target: latLng ,
        zoom: 15.0
    );

    ref.read(mapProv).changeMarker(
        id: idUser ,
        latLng: latLng
    );

    await getNewLocation(latLng);


  }


  /// PolyGon
  final Set<Polygon> polygonSet = {};

  Set<Polygon> myPolyGon() {
    final List<LatLng> coordinates = <LatLng>[];
    coordinates.add(const LatLng(37.4219983, -122.084));
    coordinates.add(const LatLng(37.400606726524735, -122.08765368908642));

    //final Set<Polygon> polygonSet = {};
    polygonSet.add(Polygon(
        polygonId: const PolygonId('poly') ,
        points: coordinates ,
        strokeColor: Colors.red
    ));
    setState(() {});

    return polygonSet;
  }


  /// PolyLines

  // polyLineCoordinates.add(const LatLng(37.4219983, -122.084));
  // polyLineCoordinates.add(const LatLng(37.400606726524735, -122.08765368908642));

  @override
  Widget build(BuildContext context) {
    print("setState(() {});");

    return PopScope(
      onPopInvoked: (v) async {
        await Navigator.maybePop(context, cameraPosition);
      },
      child: Scaffold(
        appBar: AppBar(
          title: App.text.text("Google Map", context, fontSize: 20.0,color: Colors.white) ,
          leading: !widget.isUser ? const BackButton() : IconButton.outlined(onPressed: () async {
            await Navigator.maybePop(context, cameraPosition);
          }, icon: const Icon(Icons.done)),
          actions: [

            Visibility(
              visible: !widget.isUser ? false : true,
              child: IconButton.outlined(onPressed: () async {
                // final value = await Navigator.of(context)
                //     .pushNamed(RouteGenerators.searchPlaceScreen);


                final value = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=> const SearchLocationsPage())
                );


                if(value != null) {
                   await getNewLocation(value);
                }
              }, icon: const Icon(Icons.search)),
            )

          ],
        ),


        body: AnimatedConditionalBuilder(
          duration: const Duration() ,
          // condition: completer.isCompleted  ,
          condition: cameraPosition != null ,

          builder: (context) {
            return Consumer(
                builder: (context,prov,_) {
                  return Stack(
                    children: [

                      GoogleMap(
                        mapType: MapType.normal ,

                        initialCameraPosition: cameraPosition! ,

                        markers: prov.watch(mapProv).markers ,

                        //polygons: myPolyGon() ,
                        polygons: polygonSet ,

                        onMapCreated: (GoogleMapController googleMapController) {
                          if(!completer.isCompleted) {
                            controller = googleMapController;
                            completer.complete(googleMapController);
                          }
                        } ,

                        onCameraMove: (v) async {} ,

                        onCameraIdle: () async {} ,

                        onTap: (LatLng latLng) async {
                          if(widget.isUser == true ) {
                            await getNewLocation(latLng);
                          } else {
                            return;
                          }
                        } ,

                      ) ,

                      Visibility(
                        visible: !widget.isUser ? false : true ,
                        child: Positioned(
                          right: 0 ,
                          child: IconButton.outlined(onPressed: () async {
                            await getMyCurrentLocation();
                            // final LatLng latLng_ = LatLng(widget.lat, widget.lng);
                            // await getNewLocation(latLng_);
                          }, icon: const Icon(Icons.my_location_sharp)),
                        ),
                      )


                    ],
                  );
                }
            );
          } ,


          fallback: (_) {
            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ) ,
      ),
    );
  }
}


mixin _GoogleMap_ {
  final mapProv = ChangeNotifierProvider((ref) => MapProvider());
}

class MapProvider extends ChangeNotifier {
  Set<Marker> markers = {};

  void addMarker(Marker marker) {
    markers.add(marker);
    notifyListeners();
  }

  void changeMarker({
    required String id ,
    required LatLng latLng
  }) {
    markers.clear();
    markers.remove( Marker(markerId:  MarkerId(id)));
    markers.add(Marker(markerId: MarkerId(id),position: LatLng(latLng.latitude, latLng.longitude)));
    notifyListeners();
  }

}