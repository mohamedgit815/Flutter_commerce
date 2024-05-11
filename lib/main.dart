import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/my_app.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Authentication/Login/main_login_screen.dart';
import 'package:commerce/Screens/BottomBar/main_bottom_bar_screen.dart';
import 'package:commerce/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}


Future<void> main() async {
  //runApp(const ProviderScope(child: MyApp(screen: MainLoginScreen())));


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey = App.payments.publishKeyStripe;
  await App.fcm.requestNotificationPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  //preferences.clear();

  late Widget screen;

  String? token = preferences.getString(PreferencesEnum.setToken.name);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final UserModel userModel = App.profile.getUserModel(preferences: preferences);


  if(token == "" || token == null) {

    screen = MainLoginScreen(userModel: userModel, preferences: preferences);

  } else {

    screen = MainBottomBarScreen(userModel: userModel);

  }

  runApp(ProviderScope(child: MyApp(screen: screen)));
}