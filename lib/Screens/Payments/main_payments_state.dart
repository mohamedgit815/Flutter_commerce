import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Controller/controller.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/GoogleMap/google_map.dart';
import 'package:commerce/Screens/Payments/init_payments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


abstract class BasePaymentsState {
  final paymentProv = ChangeNotifierProvider.autoDispose((ref) => IntegerProvider());
  final loadingProv = ChangeNotifierProvider.autoDispose((ref) => BooleanProvider());
  CameraPosition? latLng;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  // final List<TextEditingController> controller = [
  //   TextEditingController() , /// City[Index=0]
  //   TextEditingController() , /// Zip[Index=1]
  //   TextEditingController() , /// Phone[Index=2]
  // ];

  /// Dummy Data for Selected
  final List<Map<String,dynamic>> dummyOrderData = [
    {
      "name": "Visa"
    },
    {
      "name": "Paypal"
    }
  ];


  ChangeNotifierProvider<FetchDataProvider> fetchCartData();
  ChangeNotifierProvider<FetchDataProvider> fetchTotalAndCountCartData();


  Future<void> navigateToGoogleMap({required BuildContext context,required UserModel userModel});


  Future<void> payAndGetYourLocation({
    required InitPayments state,
    required BuildContext context ,
    required WidgetRef ref ,
    required String amount ,
    required UserModel userModel ,
    required ProviderListenable<BooleanProvider> loadingProvider
  });
}



class PaymentsState extends BasePaymentsState {

  @override
  ChangeNotifierProvider<FetchDataProvider> fetchCartData() {
    return Controller.cart.fetchCartData;
  }


  @override
  ChangeNotifierProvider<FetchDataProvider> fetchTotalAndCountCartData() {
    return Controller.cart.fetchTotalAndCountCartData;
  }


  @override
  Future<void> navigateToGoogleMap({required BuildContext context,required UserModel userModel}) async {
    final Position position  = await App.location.getCurrentLocation();
    // final List arguments = [
    //   position.latitude , position.longitude , true
    // ];

    if(context.mounted) {
      latLng = await Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
        return GoogleMapPage(lng: position.latitude, lat: position.longitude, isUser: true, userModel: userModel);
      }));



     // await Navigator.of(context).pushNamed(RouteGenerators.mapScreen,arguments: arguments);
    }
  }

  @override
  Future<void> payAndGetYourLocation({
    required InitPayments state,
    required BuildContext context ,
    required WidgetRef ref ,
    required String amount ,
    required UserModel userModel ,
    required ProviderListenable<BooleanProvider> loadingProvider
  }) async {
    ref.read(loadingProvider).falseBoolean();
    try{

    if(state.main.formState.currentState!.validate()) {

      final Position position = await App.location.getCurrentLocation();
      late LatLng latLng_;

      if(latLng == null) {

        if(context.mounted) {
          await App.alertWidgets.showAlertDialog(context: context, builder: (_) => SimpleDialog(
            title: App.text.translateText(LangEnum.currentLocation.name, context),
            children: [

              App.buttons.text(onPressed: () {
                latLng_ = LatLng(position.latitude, position.longitude);
                Navigator.maybePop(context);
              }, child: App.text.translateText(LangEnum.ok.name, context)) ,

              App.buttons.text(onPressed: () async {
                await navigateToGoogleMap(context: context, userModel: userModel);
                if(context.mounted) {
                  Navigator.maybePop(context);
                }
              }, child: App.text.translateText(LangEnum.no.name, context)) ,

            ],
          ));
        }

      } else {
        latLng_ = LatLng(latLng!.target.latitude,latLng!.target.longitude);
      }

      final List<Placemark> placeMarks = await App.map.getGeoCoding(latLng_) ;


      if(ref.read(state.main.paymentProv).integer == 1) {
         if(context.mounted) {
           return await _stripePayment(
               amount: amount,
               currency: "USD" ,
               context: context ,
               ref: ref ,
               userModel: userModel ,
               //longitude: latLng == null ? position.longitude.toString() : latLng!.target.longitude.toString() ,
               //latitude: latLng == null ? position.latitude.toString() : latLng!.target.latitude.toString(),
               latitude: latLng_.latitude.toString() ,
               longitude: latLng_.longitude.toString() ,
               city: "${placeMarks.elementAt(0).locality ?? placeMarks.elementAt(0).street}" ,
               zip: "${placeMarks.elementAt(0).postalCode}" ,
               country: '${placeMarks.elementAt(0).country}' ,
               phone: controller.text

           );
         }
      } else if(ref.read(state.main.paymentProv).integer == 2) {
        if(context.mounted) {
          return await _paypalPayment(
              total: amount,
              context: context ,
              userModel: userModel ,
              ref: ref ,
              //longitude: latLng == null ? position.longitude.toString() : latLng!.target.longitude.toString() ,
              //latitude: latLng == null ? position.latitude.toString() : latLng!.target.latitude.toString() ,
              latitude: latLng_.latitude.toString() ,
              longitude: latLng_.longitude.toString() ,
              city: "${placeMarks.elementAt(0).locality ?? placeMarks.elementAt(0).street}" ,
              zip: "${placeMarks.elementAt(0).postalCode}" ,
              country: '${placeMarks.elementAt(0).country}' ,
              phone: controller.text
          );
        }
      }

      ref.read(loadingProvider).trueBoolean();

    } else {
      ref.read(loadingProvider).trueBoolean();
    }


    } catch(_) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.addLocation.name, context: context);
      }
    }
    ref.read(loadingProvider).trueBoolean();
  }


  Future<dynamic> _paypalPayment({
    required String total,
    required UserModel userModel,
    required BuildContext context ,
    required WidgetRef ref ,
    required String longitude ,
    required String latitude ,
    required String city ,
    required String zip ,
    required String country ,
    required String phone ,
    String? currency ,
  }) async {
    FocusScope.of(context).unfocus();

     await App.payments.paypal(
        total: total,
        context: context,
        currency: currency ?? 'USD' ,

        onPop: (v) {
          return _cancel_(ref: ref, context: context);
        },

        onCancel: () {
          return _cancel_(ref: ref, context: context);
        },


        onSuccess: (map) async {
          await _onSuccess_(
              total: total ,
              userModel: userModel ,
              context: context ,
              ref: ref ,
              longitude: longitude ,
              latitude: latitude ,
              city: city ,
              zip: zip ,
              phone: phone ,
              country: country
          );
        }
    );
  }


  Future<void> _stripePayment({
    required String amount,
    required String currency ,
    required UserModel userModel,
    required BuildContext context ,
    required WidgetRef ref ,
    required String longitude ,
    required String latitude ,
    required String city ,
    required String zip ,
    required String country ,
    required String phone ,
  }) async {
    return await App.payments.stripePayments(
        amount: amount ,
        currency: currency
    ).then((value) async {
      return await _onSuccess_(
          total: amount,
          userModel: userModel,
          context: context,
          ref: ref,
          longitude: longitude,
          latitude: latitude,
          city: city,
          zip: zip,
          phone: phone ,
          country: country
      );
    }).catchError((err){
      return _cancel_(ref: ref, context: context);
    });
  }




  Future<void> _onSuccess_({
    required String total,
    required UserModel userModel,
    required BuildContext context ,
    required WidgetRef ref ,
    required String longitude ,
    required String latitude ,
    required String city ,
    required String zip ,
    required String country ,
    required String phone ,
  }) async {
     await _purchaseProducts_(
        userModel: userModel ,
        context: context ,
        lang: longitude ,
        lit: latitude ,
        city: city ,
        zip: zip ,
        phone: phone ,
        country: country
    );

    if(context.mounted) {
      await Controller.cart
          .deleteAllCart(userModel: userModel, context: context)
          .then((value) async {
        ref.read(fetchCartData()).removeAll();
      });

      ref.read(fetchTotalAndCountCartData()).updateAt(
          index: 0, key: 'count', value: 0
      );

    }
    ref.read(loadingProv).trueBoolean();

    if(context.mounted) {
      await Navigator.pushNamedAndRemoveUntil(
          context, RouteGenerators.bottomScreen, (route) => false,arguments: userModel);
    }
  }


  void _cancel_({
    required WidgetRef ref ,
    required BuildContext context
  }) {
    ref.read(loadingProv).trueBoolean();
    ScaffoldMessenger.of(context)
        .showSnackBar(
        const SnackBar(content: Text("The Process has been Canceled"))
    );
  }


  Future<void> _purchaseProducts_({
    required UserModel userModel ,
    required BuildContext context ,
    required String lang ,
    required String lit ,
    required String city ,
    required String zip ,
    required String country ,
    required String phone ,
  }) async {
    return await Controller.order.purchaseProducts(
        userModel: userModel ,
        context: context ,
        lang: lang ,
        lit: lit ,
        city: city ,
        zip: zip ,
        phone: phone ,
        country: country
    );
  }

}