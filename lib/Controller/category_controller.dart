import 'dart:async';
import 'package:commerce/App/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



abstract class BaseCategoryController {
  static final categoryProv = FutureProvider<List<dynamic>>((ref) async => await _getCategory());
  static Future<List<dynamic>> _getCategory() async {
    try{
      final Response response = await App.dio.get(url: App.strings.getAllCategory);
      final List<dynamic> data = await response.data['data'];

      if(response.statusCode == 200) {
        return data;

      } else {

        // if(context.mounted) {
        //   App.alertWidgets.snackBar(text: "check your Internet", context: context);
        // }

        throw Exception("check your Internet");
      }

    } on DioException catch(_) {
      // if(context.mounted) {
      //   App.alertWidgets.snackBar(text: "check your Internet", context: context);
      // }
      throw Exception("check your Internet");
    }
  }

}

class CategoryController extends BaseCategoryController {}