import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


abstract class BaseFirebaseFCM {

  final FirebaseMessaging fcm = FirebaseMessaging.instance;


  final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=AAAAPME1g3I:APA91bHXv-XpmPuUq3TvA71nDC39-5G8qmfVTr6NyZ6KPrM_arEYKpkQEA_tLVOCnb20rNGzVRlKbMSmFZdAko5O5k0s1345K5R5LMGaOQweHRChkb-4NqJZmhTqgyGaIjrqbDcKY7xW",
        },
      )
  );


  Future<void> requestNotificationPermission();


  /// Get Token for Specific Device
  Future<String?> getToken();


  /// Receive the Message and go to any Screen you want
  StreamSubscription<RemoteMessage> getOnOpenedMessageApp({
    required BuildContext context ,
    required String message
  });


  Future<void> getInitBackgroundMessage({
    required BuildContext context ,
    required String message
  });


  Future<void> sendMessageByApiForSpecificUser({
    required String senderToken ,
    required String title ,
    required String body ,
    required BuildContext context
  });



  /// Topics
  Future<void> sendMessageByTopicForUsers({
    required String topic ,
    required String title ,
    required String body ,
    required BuildContext context
  });

  Future<void> subscribeTopic({required String topic});

  Future<void> unsubscribeTopic({required String topic});
}











class FirebaseFCM extends BaseFirebaseFCM {

  @override
  Future<void> requestNotificationPermission() async {
    //FirebaseMessaging messaging = FirebaseMessaging.instance;
     await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // if(settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print("true");
    // } else {
    //   print("false");
    // }

    // print('Notification permission granted: ${settings.authorizationStatus}');
  }


  @override
  Future<String?> getToken() async {
    final String? token = await super.fcm.getToken();
    //print(token);
    return token;
  }



  @override
  Future<void> getInitBackgroundMessage({
    required BuildContext context ,
    required String message
  }) async {
    final RemoteMessage? initial = await fcm.getInitialMessage();
    if(initial != null && initial.notification != null) {
      // Navigator.pushNamed(context, RouteGenerators.registerScreen);
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(message)
            )
        );
      }
    }
  }




  @override
  StreamSubscription<RemoteMessage> getOnOpenedMessageApp({
      required BuildContext context ,
      required String message
  }) {
    return FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      //Navigator.pushNamed(context, RouteGenerators.registerScreen);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(message)
          )
      );
    });
  }




  @override
  Future<void> sendMessageByApiForSpecificUser({
    required String senderToken ,
    required String title ,
    required String body ,
    required BuildContext context
  }) async {
   try{
     final Response response = await dio.postUri(
         Uri.parse('/send'),
         data: {
           "to": senderToken ,
           //"to": "deoo1VrrReKI7ltQk_Rl0e:APA91bEkju6PtdGC-EeRt0rtB4S6TMCtWclsPkKgPmcFfD5BLRXeufwe6MzOaAgz8ynJ_all3k8PvCQm0XegBMu-as8p1yvHx-isH4bFNPUANw2KXg7hQLrk72xr_nOeJ13xxW_bUTSP",
           "notification": {
             "title": title ,
             "body": body ,
             // "image":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHH8mepO4avVq5NJFuruMoqN02xAqm5Jk7IryH9iVuNw&s",
             // "mutable_content" : true,
             // "sound": "Tri-tone"
           },

           // "data": {
           // "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHH8mepO4avVq5NJFuruMoqN02xAqm5Jk7IryH9iVuNw&s",
           // "dl": "<deeplink action on tap of notification>"
           // }
         }
     );

     if(response.statusCode == 200) {
       if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
                 content: Text("Message has Sent")
             )
         );
       }
     }
   }on DioException catch(e) {

     if (context.mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               content: Text(e.response?.statusMessage ?? "Exception")
           )
       );
     }
   }
  }





  @override
  Future<void> sendMessageByTopicForUsers({
    required String topic ,
    required String title ,
    required String body ,
    required BuildContext context
  }) async {
    try{
      final Response response = await dio.postUri(
          Uri.parse('/send/topics'),
          data: {
            "to": '/$topic' ,
            //"to": "deoo1VrrReKI7ltQk_Rl0e:APA91bEkju6PtdGC-EeRt0rtB4S6TMCtWclsPkKgPmcFfD5BLRXeufwe6MzOaAgz8ynJ_all3k8PvCQm0XegBMu-as8p1yvHx-isH4bFNPUANw2KXg7hQLrk72xr_nOeJ13xxW_bUTSP",
            "notification": {
              "title": title ,
              "body": body ,
              // "image":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHH8mepO4avVq5NJFuruMoqN02xAqm5Jk7IryH9iVuNw&s",
              // "mutable_content" : true,
              // "sound": "Tri-tone"
            },

            // "data": {
            // "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHH8mepO4avVq5NJFuruMoqN02xAqm5Jk7IryH9iVuNw&s",
            // "dl": "<deeplink action on tap of notification>"
            // }
          }
      );

      if(response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Message has Sent")
              )
          );
        }
      }

    }on DioException catch(e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(e.response?.statusMessage ?? "Exception")
            )
        );
      }
    }

  }

  @override
  Future<void> subscribeTopic({required String topic}) async {
    return await fcm.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeTopic({required String topic}) async {
    return await fcm.unsubscribeFromTopic(topic);
  }



}