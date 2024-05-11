import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/WidgetsHelper/Global/auth_text_feild.dart';
import 'package:commerce/App/WidgetsHelper/Global/product_data.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Screens/Products/init_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



abstract class BaseGlobalWidgets {
  Row expanded({required Widget child, int? flex});

  Widget loadingWidget({bool? parent});

  Widget authFormField({
    required TextInputAction inputAction ,
    required TextInputType inputType ,
    required BuildContext context ,
    required TextEditingController controller ,
    List<TextInputFormatter>? inputFormatter ,
    FormFieldValidator<String>? validator ,
    ValueChanged<String>? onSubmitted ,
    Widget? suffixIcon, Widget? prefixIcon ,
    String? hint ,
    bool? password ,
    bool? phone ,
  });


  Widget fetchProductDataByCategory({
    required InitProducts state ,
    required WidgetRef provider ,
    required BoxConstraints constraints ,
    required ProviderListenable<FetchDataProvider> listenable ,
    required ScrollController scrollController ,
    required String pageStorageKey ,
    required UserModel userModel
  });

}



class GlobalWidgets extends BaseGlobalWidgets {

  @override
  Row expanded({required Widget child, int? flex}) {
    return Row(
      children: [

        const Spacer(flex: 1,),

        Expanded(
            flex: flex ?? 12,
            child: child
        ),

        const Spacer(flex: 1,),
      ],
    );
  }

  @override
  Widget loadingWidget({bool? parent}) {
    bool value = parent ?? false;
    if(value == true){
      return const Scaffold(body: CircularProgressIndicator.adaptive());
    } else {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
  }



  @override
  Widget authFormField({
    required TextInputAction inputAction ,
    required TextInputType inputType ,
    required BuildContext context ,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatter ,
    FormFieldValidator<String>? validator ,
    ValueChanged<String>? onSubmitted ,
    Widget? suffixIcon, Widget? prefixIcon ,
    String? hint ,
    bool? password ,
    bool? phone ,
}) {
    return expanded(
      child: AuthTextField(
          controller: controller ,
          inputAction: inputAction ,
          inputType: inputType ,
          validator: validator ,
          password: password ,
          onSubmitted: onSubmitted ,
          hint: hint ,
          prefixIcon: prefixIcon ,
          suffixIcon: suffixIcon ,
          inputFormatter: inputFormatter,
          phone: phone ?? true ,
      ),
    );
  }

  @override
  Widget fetchProductDataByCategory({
    required InitProducts state ,
    required WidgetRef provider ,
    required BoxConstraints constraints ,
    required ProviderListenable<FetchDataProvider> listenable ,
    required ScrollController scrollController ,
    required String pageStorageKey ,
    required UserModel userModel ,
}) {
    return FetchProductDataByCategory(
        state: state,
        prov: provider,
        constraints: constraints,
        listenable: listenable,
        pageStorageKey: pageStorageKey ,
        scrollController: scrollController ,
        userModel: userModel,
    );
  }

}