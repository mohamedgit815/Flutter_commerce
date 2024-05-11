import 'package:commerce/App/Services/Paypal/flutter_paypal_checkout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class BasePayments {
  String publishKeyStripe = 'pk_test_51LT8bECiM4hxmV5zmloRR4s0iwC7Cq81ROyRUVKiQMfk18FgEuJh0aYEy3Va13mGQT5sDFjE1qRNJz0NgvuiTilK00DkGPOvGV';
  String secretKeyStripe = 'sk_test_51LT8bECiM4hxmV5zMRPFQciLRXSIxi4IfFiQveyfpOtaFHiGJil121uYV5Di83hpnxMZMAi4MFuLQkNBK7RwoIJ400Ep3U4lXw';


  Future<dynamic> paypal({
    required String total ,
    required BuildContext context ,
    Function? onSuccess ,
    Function? onError,
    Function(bool)? onPop,
    VoidCallback? onCancel,
    String? currency ,
    int? discount ,
    bool? canPop
  });

   Future<void> stripePayments({
    required String amount ,
    required String currency
  });
}

class Payments extends BasePayments {


  /// Paypal
  @override
   Future<dynamic> paypal({
    required String total ,
    required BuildContext context ,
    Function? onSuccess ,
    Function? onError,
    Function(bool)? onPop,
    VoidCallback? onCancel,
    String? currency ,
    int? discount ,
    bool? canPop ,
  }) async {
    return await Navigator.push(context ,
        CupertinoPageRoute(builder: (_) => PopScope(
          canPop: canPop ?? true ,
          onPopInvoked: onPop ,
          child: PaypalCheckout(
            sandboxMode: true,
            clientId: "AWJcD8TzNirEt0xAJUzO0gFLoLqh93noYaeFkMpKhPlCJ-5vgEFkHfl12IsDKL0wxQkjLX6iYjWnIkIy",
            secretKey: "EH934ogc3ZTsfWBVOLfmxg9Tj_UbULUxm_hw4tAxK9NtvPQhtkWDynmmh7WiLwxOFsd6zrp8IRirnBWf",
             returnURL: "success.snippetcoder.com",
             cancelURL: "cancel.snippetcoder.com",
             //returnURL: "https://www.google.com/",
             //cancelURL: "https://www.google.com/",

            transactions:  [
              {
                "amount": {
                  "total": total ,
                  //totalPrice
                  //"totalPrice": total,
                  "currency": currency ?? "USD",
                  "details": {
                    "subtotal": total ,
                    "shipping": '0',
                    "shipping_discount": discount ?? 0
                  }
                },
                "description": "The payment transaction description.",
                "item_list": const {
                  // "items": [
                  //   {
                  //     "name": "Apple",
                  //     "quantity": 4,
                  //     "price": '5',
                  //     "currency": "USD"
                  //   },
                  //   {
                  //     "name": "Pineapple",
                  //     "quantity": 5,
                  //     "price": '10',
                  //     "currency": "USD"
                  //   }
                  // ],
                  // // shipping address is Optional
                  // "shipping_address": {
                  //   "recipient_name": "Raman Singh",
                  //   "line1": "Delhi",
                  //   "line2": "",
                  //   "city": "Delhi",
                  //   "country_code": "IN",
                  //   "postal_code": "11001",
                  //   "phone": "+00000000",
                  //   "state": "Texas"
                  // },
                }
              }
            ],

            note: "PAYMENT_NOTE",

            onSuccess: onSuccess ?? (Map params) async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  const SnackBar(content: Text("Success"))
              );
                } ,

                onError: onError ??(error) {
          Navigator.maybePop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(
              const SnackBar(content: Text("Field"))
          );
                } ,


          onCancel: onCancel ?? () {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("The Process has been Canceled"))
            );
          },
              ),
        )
        )
    );
  }



  /// Stripe
  @override
  Future<void> stripePayments({
    required String amount ,
    required String currency
  }) async {
    try {
      final String clientSecret =
      await _getClientSecret(
          amount: amount, currency: currency);

      await _initializePaymentSheet(
          paymentSecret: clientSecret,
          merchantDisplayName: "Elsherif"
      );

      await Stripe.instance.presentPaymentSheet();



    }on StripeException catch(e) {
      throw Exception(e.toJson());
    }

  }


  Future<PaymentSheetPaymentOption?> _initializePaymentSheet({
    required String paymentSecret ,
    required String merchantDisplayName
  }) async {
    return await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentSecret ,
          merchantDisplayName: merchantDisplayName ,
          //style: ThemeMode.dark
        ) ,
    );
  }


 //LaunchTheme
  // Future<String> _getClientSecret({
  //   required String amount ,
  //   required String currency
  // }) async {
  //   //  try{
  //
  //    Map<String, String>? headers = {
  //     'Authorization': 'Bearer $secretKeyStripe',
  //     "Content-Type": "application/x-www-form-urlencoded"
  //   };
  //
  //   final Map<String,dynamic> body = <String,dynamic>{
  //     //"amount": "20.0" ,
  //     "amount": _calculateAmount(amount) ,
  //     "currency": currency
  //   };
  //
  //   final http.Response response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents') ,
  //       headers: headers ,
  //       body: body ,
  //   );
  //
  //   final data = await jsonDecode(response.body);
  //
  //   return data['client_secret'];
  //
  // }


  String _calculateAmount(String amount) {
    final calculate = (int.parse(amount)) * 100;
    return calculate.toString();
  }

  Future _getClientSecret({
    required String amount ,
    required String currency
  }) async {
    try{
      final Dio dio = Dio(BaseOptions(baseUrl: 'https://api.stripe.com'));

      final Response response = await dio.post('/v1/payment_intents',
          options: Options(
              headers: {
                'Authorization': 'Bearer $secretKeyStripe',
                "Content-Type": "application/x-www-form-urlencoded"
              }
          ) ,
          data: {
            "amount": _calculateAmount(amount) ,
            "currency": currency
          }
      );

      return await response.data['client_secret'];
    } on DioException catch(e) {
      throw Exception(e.message);
    }
  }


}