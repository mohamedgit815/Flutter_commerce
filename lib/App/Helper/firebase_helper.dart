// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// abstract class BaseFireBase {
//
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   String idToken();
//
//   Future<String?> getToken();
//
//   Timestamp timeStampNow();
//
// }
//
// class FireBase extends BaseFireBase {
//
//
//   @override
//   Future<String?> getToken() async {
//     return await messaging.getToken();
//   }
//
//   @override
//   String idToken() {
//     return auth.currentUser!.uid;
//   }
//
//   @override
//   Timestamp timeStampNow() {
//     return Timestamp.now();
//   }
//
//
// }