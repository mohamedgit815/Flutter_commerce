import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class SaveProfile {

  Future<void> setUserModel({required SharedPreferences preferences, required Response response}) async {
    await preferences.setString(PreferencesEnum.setToken.name, await response.data['token']);
    await preferences.setString(PreferencesEnum.setUserEmail.name, await response.data['data']['email']);
    await preferences.setString(PreferencesEnum.setUserName.name, await response.data['data']['name']);
    await preferences.setString(PreferencesEnum.setUserId.name, await response.data['data']['_id']);
    await preferences.setBool(PreferencesEnum.setIsAdmin.name, await response.data['data']['isAdmin']);
    await preferences.setString(PreferencesEnum.createdAt.name, await response.data['data']['createdAt']);
    await preferences.setString(PreferencesEnum.updatedAt.name, await response.data['data']['updatedAt']);
  }

  UserModel getUserModel({required SharedPreferences preferences}) {

    final Map<String,dynamic> data = {
      PreferencesEnum.createdAt.name: preferences.getString(PreferencesEnum.createdAt.name) ,
      PreferencesEnum.updatedAt.name: preferences.getString(PreferencesEnum.updatedAt.name) ,
      PreferencesEnum.setToken.name: preferences.getString(PreferencesEnum.setToken.name) ,
      PreferencesEnum.setUserId.name: preferences.getString(PreferencesEnum.setUserId.name) ,
      PreferencesEnum.setIsAdmin.name: preferences.getBool(PreferencesEnum.setIsAdmin.name) ,
      PreferencesEnum.setUserName.name: preferences.getString(PreferencesEnum.setUserName.name) ,
      PreferencesEnum.setUserEmail.name: preferences.getString(PreferencesEnum.setUserEmail.name)
    };
    final UserModel userModel = UserModel.fromJson(data);
    return userModel;
  }



  Future<bool> logoutUserModel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.clear();
  }




  // logoutUserModel(SharedPreferences preferences) {
  //   return
  // }

}