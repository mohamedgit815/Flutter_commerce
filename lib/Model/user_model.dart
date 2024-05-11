import 'package:commerce/App/Utils/app_enums.dart';

class UserModel {

  final String? id, name, email, token;
  final bool? isAdmin;

  const UserModel({
    required this.id ,
    required this.name ,
    required this.email ,
    this.isAdmin ,
    required this.token
  });

  factory UserModel.fromJson(Map<String,dynamic>json) {
    return UserModel(
        id: json[PreferencesEnum.setUserId.name] ?? "" ,
        name: json[PreferencesEnum.setUserName.name] ?? "" ,
        email: json[PreferencesEnum.setUserEmail.name] ?? "" ,
        isAdmin: json[PreferencesEnum.setIsAdmin.name] ?? false ,
        token: json[PreferencesEnum.setToken.name] ?? ""
    );
  }

}