import 'dart:io';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Cart/main_cart_screen.dart';
import 'package:commerce/Screens/Products/main_products_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBarProvider extends ChangeNotifier {

  // /// List for Bottom Navigation Bar
  // final List<Widget> pages = const [
  //    MainProductsScreen() ,
  //    MainCartScreen() ,
  // ];


  List<Widget> pages({required UserModel userModel}) {
    final List<Widget> pages = [
       MainProductsScreen(user: userModel) ,
       MainCartScreen(userModel: userModel)
    ];

    return pages;
  }


  /// Integer
  int integer = 0;

  int equalValueInteger(int v) {
    notifyListeners();
    return integer = v;
  }
}

class BooleanProvider extends ChangeNotifier {
  bool boolean = true;

  bool switchBoolean(){
    notifyListeners();
    return boolean = !boolean;
  }

  bool trueBoolean(){
    notifyListeners();
    return boolean = true;
  }

  bool falseBoolean(){
    notifyListeners();
    return boolean = false;
  }
}

class IntegerProvider extends ChangeNotifier {
  /// Integer
  int integer = 0;

  int equalValueInteger(int v) {
    notifyListeners();
    return integer = v;
  }
}

class StringProvider extends ChangeNotifier {
  /// Strings
  String strings = '';

  String equalValueString(String v){
    notifyListeners() ;
    return strings = v;
  }

  void equalStringNull(){
    strings = '';
    notifyListeners();
  }
}

class PreferencesStringProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  late String _value;
  late String _key;
  String get value => _value;

  PreferencesStringProvider({required String key , required String defaultName}) {
    _value = defaultName;
    _key = key;
    _loadFromPrefs();
  }

  toggleLang(String v) async {
    _value = v;
    await _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _value = _prefs.getString(_key) ?? _value;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    await _prefs.setString(_key, _value);
  }
}

class PreferencesIntegerProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  late int _value;
  late String _key;
  int get value => _value;

  PreferencesIntegerProvider({required String key , required int defaultName}) {
    _value = defaultName;
    _key = key;
    _loadFromPrefs();
  }

  toggleLang(int v) {
    _value = v;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _value = _prefs.getInt(_key) ?? _value;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    await _prefs.setInt(_key, _value);
  }
}

class PreferencesBooleanProvider extends ChangeNotifier {
  /// To Load Data by Shared Preferences

  late String _key;
  SharedPreferences? _prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  PreferencesBooleanProvider({required String key}) {
    _darkTheme = true;
    _key = key;
    _loadFromPrefs();
  }


  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }


  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }


  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs!.getBool(_key) ?? true;
    notifyListeners();
  }


  _saveToPrefs() async {
    await _initPrefs();
    await _prefs!.setBool(_key, _darkTheme);
  }
}

class HiveProvider extends ChangeNotifier {
  List dataHive = [];


  void fetchDataHive({required Box boxName}) {
    dataHive = boxName.values.toList();
    notifyListeners();
  }

  void addHive({required dynamic model}) {
    dataHive.add(model);
    notifyListeners();
  }

  void deleteHive({required int index}) {
    dataHive.removeAt(index);
    notifyListeners();
  }

  void updateHive({required int index , required dynamic model}) {
    dataHive[index] = model;
    notifyListeners();
  }

}

class ImagePickerProvider extends ChangeNotifier {
  /// To Get Images from Gallery or Camera

  File? fileImage;
  Future<void> getImagePicker({required BuildContext context,required ImageSource imageSource}) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: imageSource);

      if (image != null) {
        fileImage = File(image.path);
      } else {
        //customSnackBar(text: 'your arn\'t selected Image', context: context);
      }

      notifyListeners();
    }on PlatformException catch(_) {
      //customSnackBar(text: 'your arn\'t selected Image', context: context);
    }
  }

  void deleteImagePicker() {
    fileImage = null;
    notifyListeners();
  }

}

class STTProvider extends ChangeNotifier {
  // final SpeechToText speechToText = SpeechToText();
  // bool speechEnable = false;
  // bool isListening = false;
  // //late bool isAvailable;
  // String wordSpeak = "";
  // final TextEditingController wordSpeakController = TextEditingController();
  // double confidenceLevel = 0;
  //
  // initSpeech() async {
  //   try{
  //   speechEnable = await speechToText.initialize();
  //   }on PlatformException catch(e) {
  //     log(e.code);
  // // App.alertWidgets.snackBar(text: "Check your Permission", context: context);
  //
  // }
  //
  //   notifyListeners();
  // }
  //
  // Future<void> startListening() async {
  //   await speechToText.listen(
  //       onResult: (SpeechRecognitionResult result) {
  //         wordSpeak = result.recognizedWords;
  //         wordSpeakController.text = result.recognizedWords;
  //         confidenceLevel = result.confidence;
  //         notifyListeners();
  //       }).then((value) {
  //         isListening = true;
  //       });
  //
  //   confidenceLevel = 0;
  //   notifyListeners();
  // }
  //
  // Future<void> stopListening() async {
  //   await speechToText.stop();
  //   isListening = false;
  //   notifyListeners();
  // }
  //
  // void clearController() {
  //   wordSpeakController.clear();
  //   notifyListeners();
  // }
  //
  // void equalController(String value) {
  //   wordSpeakController.text = value;
  //   notifyListeners();
  // }

}

class FetchDataProvider extends ChangeNotifier {
  List<dynamic> dataList = [];
  double total = 0;
  bool hasMore = true;


  Future<void> fetchData({
    required String url ,
    required int limit,
    required int page ,
    String? token
  }) async {
    //final http.Response response = await http.get(Uri.parse(url));
    //final List<dynamic> data = await jsonDecode(response.body);

    final Response response = await App.dio.get(url: url,token: token);
    final List<dynamic> data = await response.data['data'];


    if(response.statusCode == 200 ) {

      if(response.data.length! <= 2) {
        hasMore = false;
      } else {
        hasMore = true;
      }

      dataList.addAll(data.map((e) => e).toList());

      notifyListeners();

    }
  }


  Future<void> fetchDataRandom({required String url , required int limit,required int page }) async {
    // final http.Response response = await http.get(Uri.parse(url));
    // final Map<String,dynamic> map = await jsonDecode(response.body);
    // final List<dynamic> data = map['results'];


    // print(response.contentLength);
    //
    // if(response.statusCode == 200 ) {
    //
    //   if(dataList.length < limit) {
    //     hasMore = false;
    //   } else {
    //     hasMore = true;
    //   }
    //
    //   dataList.addAll(data.map((e) => e).toList());
    //
    //   notifyListeners();

   // }
  }


  Future<void> refreshData({
    required int page ,
    required int limit ,
    required String url ,
    required WidgetRef ref ,
    required ProviderListenable provider
  }) async {

    page = 1;
    hasMore = true;
    dataList.clear();

    await ref
        .read(provider)
        .fetchData(
        url: url ,
        limit: limit ,
        page: page++
    );

    //await fetchData(url: url, limit: limit, page: page);

    notifyListeners();
  }


   changeBoolValue() {
    // bool value = dataList.elementAt(0);
    // // if(value) {
    // //   dataList[0] = false;
    // // }
     dataList[0] = !dataList[0];
     notifyListeners();
  }
  int getCount() {
    notifyListeners();
    return dataList.length;
  }

  void removeAt({required int index}) {
    dataList.removeAt(index);
    notifyListeners();
  }

  void remove({required Object value}) {
    dataList.remove(value);
    notifyListeners();
  }

  void removeAll() {
    dataList.clear();
    notifyListeners();
  }

  add({required dynamic value}) {
    dataList.add(value);
    notifyListeners();
  }

  update({required int index, required dynamic value}) {
    dataList[index] = value;
    notifyListeners();
  }

  updateAt({required int index, required String key, required dynamic value}) {
    dataList.elementAt(index)[key] = value;
    notifyListeners();
  }


  void updateInteger({required int index ,required bool plus , required String updateKey}) {
    if(plus) {
      dataList.elementAt(index)[updateKey]++;
    } else {

      if(dataList.elementAt(index)[updateKey] == 0) {
        return;
      } else {
        dataList.elementAt(index)[updateKey]--;
      }

    }
    notifyListeners();
  }
}

class TestFetch extends ChangeNotifier {
  List<dynamic> data = [];

  addData() {

    //data.addAll();
  }
}