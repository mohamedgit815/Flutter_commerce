import 'package:commerce/App/app.dart';
import 'package:country_code_text_field/country_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon, prefixIcon;
  final String? hint;
  final bool? password , phone;


  const AuthTextField({
    super.key ,
    required this.controller ,
    required this.inputAction ,
    required this.inputType ,
    this.phone = true ,
    this.inputFormatter ,
    this.validator ,
    this.onSubmitted ,
    this.prefixIcon ,
    this.suffixIcon ,
    this.password ,
    this.hint
  });

  @override
  Widget build(BuildContext context) {

    final OutlineInputBorder outlineInputBorder
    = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0) ,
        borderSide: BorderSide(
            color: App.color.helperTransparent,
            width: 0
        )
    );

    if(phone ?? true) {
      return TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: inputType,
        textInputAction: inputAction,
        onFieldSubmitted: onSubmitted,
        style: TextStyle(color: App.theme.conditionTheme(
            context: context,
            light: App.color.helperBlack,
            dark: App.color.helperWhite
        ) ),
        cursorColor: App.theme.conditionTheme(
            context: context,
            light: App.color.lightMain,
            dark: App.color.darkMain
        ) ,
        inputFormatters: inputFormatter,
        obscureText: password ?? false,
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: App.theme.conditionTheme(
                context: context,
                light: App.color.helperWhite,
                dark: App.color.darkFirst
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            focusedBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder ,
            focusedErrorBorder: outlineInputBorder
        ),
      );
    } else {
      return CountryCodeTextField(
        controller: controller,
        keyboardType: inputType,
        textInputAction: inputAction,
        onSubmitted: onSubmitted,
        backgroundColor: Colors.teal ,
        style: TextStyle(color: App.theme.conditionTheme(
            context: context,
            light: App.color.helperBlack,
            dark: App.color.helperWhite
        ) ) ,
        countryCodeTextStyle: TextStyle(color: App.theme.conditionTheme(
            context: context,
            light: App.color.helperBlack,
            dark: App.color.helperWhite
        ) ),
        cursorColor: App.theme.conditionTheme(
            context: context,
            light: App.color.lightMain,
            dark: App.color.darkMain
        ) ,
        inputFormatters: inputFormatter,
        initialCountryCode: "EG",
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: App.theme.conditionTheme(
                context: context,
                light: App.color.helperWhite,
                dark: App.color.darkFirst
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            focusedBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder ,
            focusedErrorBorder: outlineInputBorder
        ),
      );
    }
  }
}
