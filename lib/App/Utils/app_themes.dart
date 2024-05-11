import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseAppThemes {

  ProviderListenable<PreferencesBooleanProvider> themeProvider =
  ChangeNotifierProvider((ref) => PreferencesBooleanProvider(
      key: PreferencesEnum.preferencesTheme.name
  ));

  Color conditionTheme({
    required BuildContext context ,
    required Color light ,
    required Color dark
  });

  /// This is for Dark Theme
  ThemeData darkThemeData();

  /// This is for Light Theme
  ThemeData lightThemeData();
}

class AppThemes extends BaseAppThemes {

  @override
  Color conditionTheme({
    required BuildContext context ,
    required Color light ,
    required Color dark
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if(isDark) {
      return dark;
    } else {
      return light;
    }
  }


  @override
  ThemeData darkThemeData() {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark ,
        primaryColor: App.color.darkMain ,
        primaryColorDark: App.color.darkMain ,
        scaffoldBackgroundColor: App.color.darkSecond ,
        canvasColor: App.color.darkMain ,
        highlightColor: App.color.darkMain.withOpacity(0.2),
        splashColor: App.color.darkMain.withOpacity(0.2),
        hoverColor: App.color.darkMain.withOpacity(0.2) ,
        disabledColor: App.color.darkMain.withOpacity(0.2) ,
        dividerColor: App.color.darkMain ,


        appBarTheme: AppBarTheme(
        backgroundColor: App.color.darkSecond ,
        foregroundColor: App.color.helperWhite ,
        elevation: 0 ,
        actionsIconTheme: IconThemeData(
            color: App.color.helperWhite ,
            size: 25.0
        ),
        iconTheme: IconThemeData(
            color: App.color.helperWhite ,
            size: 25.0
        ) ,
      ) ,
        bottomAppBarTheme: const BottomAppBarTheme() ,
        drawerTheme: DrawerThemeData(
          backgroundColor: App.color.darkFirst ,
          //scrimColor: App.color.genera.helperBlack.withOpacity(3.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        ) ,
        tabBarTheme: const TabBarTheme() ,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: App.color.darkFirst ,
          type: BottomNavigationBarType.fixed ,
          selectedItemColor: App.color.darkMain ,
          unselectedItemColor: App.color.grey
        ) ,
        navigationRailTheme: const NavigationRailThemeData() ,
        navigationBarTheme: const NavigationBarThemeData() ,
        navigationDrawerTheme: const NavigationDrawerThemeData() ,




      /// Button
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: MaterialStateProperty.all(20.0) ,
            iconColor: MaterialStateProperty.all(App.color.helperWhite) ,
            foregroundColor: MaterialStateProperty.all(App.color.helperWhite) ,
            //backgroundColor: MaterialStateProperty.all(App.color.generalWhite) ,
          )
      ),
        filledButtonTheme: FilledButtonThemeData(
           style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(App.color.darkMain) ,
               iconColor: MaterialStateProperty.all(App.color.helperWhite) ,
               foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite)
           )
       ) ,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: App.color.darkMain ,
          foregroundColor: App.color.helperWhite ,
      ) ,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(App.color.darkMain) ,
              iconColor: MaterialStateProperty.all(App.color.helperWhite) ,
              foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite)
          )
      ),
        textButtonTheme: TextButtonThemeData(
           style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(App.color.darkMain) ,
               foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite) ,
               iconColor: MaterialStateProperty.all(App.color.helperWhite)
        )
       ) ,
        outlinedButtonTheme: OutlinedButtonThemeData(
           style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(App.color.darkMain) ,
               foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite) ,
               iconColor: MaterialStateProperty.all(App.color.helperWhite) ,
               side: MaterialStateProperty.all(BorderSide(color: App.color.helperWhite,width: 1.5))
           )
       ) ,
        menuButtonTheme: MenuButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(App.color.darkFirst) ,
                foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite) ,
                iconColor: MaterialStateProperty.all(App.color.helperWhite)
            )
        ) ,
        dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle() ,
          inputDecorationTheme: InputDecorationTheme() ,
          textStyle: TextStyle()
        ) ,




      /// Helper
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(App.color.darkMain),
          trackColor: MaterialStateProperty.all(App.color.grey.shade300) ,

        ) ,
        checkboxTheme: CheckboxThemeData(
          splashRadius: 20.0 ,
          checkColor: MaterialStateProperty.all(App.color.darkMain) ,
          fillColor: MaterialStateProperty.all(App.color.helperWhite) ,
          overlayColor: MaterialStateProperty.all(App.color.darkMain) ,
          side: BorderSide(color: App.color.helperWhite,width: 1.5) ,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)) ,
        ) ,
        radioTheme: RadioThemeData(
          splashRadius: 20.0 ,
          fillColor: MaterialStateProperty.all(App.color.helperWhite) ,
          overlayColor: MaterialStateProperty.all(App.color.darkMain) ,
        ) ,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color:  App.color.darkMain,
          linearTrackColor: App.color.grey.shade700 ,
          refreshBackgroundColor: App.color.helperWhite ,
          circularTrackColor: App.color.grey.shade700 ,
          linearMinHeight: 5.0 ,
        ) ,
        sliderTheme: SliderThemeData(
        thumbColor: App.color.darkMain ,
        overlayColor: App.color.darkMain ,
        activeTrackColor: App.color.darkMain ,
        inactiveTrackColor: App.color.grey.shade700 ,
        //activeTickMarkColor: Colors.blue
      ),



      /// Alerts
        snackBarTheme: SnackBarThemeData(
          backgroundColor: App.color.darkMain ,
          //backgroundColor: App.color.generalGrey.shade300 ,
          elevation: 0 ,
          contentTextStyle: TextStyle(
            fontSize: 17.0 ,
            color: App.color.helperWhite
          ) ,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0) ,
                topRight: Radius.circular(10.0)
            ) ,
          )
        ) ,
        bannerTheme: MaterialBannerThemeData(
          backgroundColor: App.color.darkMain ,
          //surfaceTintColor: Colors.red ,
          dividerColor: App.color.helperWhite ,
          elevation: 5.0,
          padding: const EdgeInsets.all(5.0),
          contentTextStyle: TextStyle(
            color: App.color.helperWhite ,
            fontSize: 17.0 ,
          )
        ) ,
        bottomSheetTheme: BottomSheetThemeData(
          //backgroundColor: App.color.darkMainColor,
            //modalBackgroundColor: Colors.red,
          backgroundColor: App.color.darkSecond ,
          surfaceTintColor: App.color.darkMain ,
          elevation: 0 ,
        ) ,
        dialogTheme: DialogTheme(
            backgroundColor: App.color.darkSecond ,
            surfaceTintColor: App.color.darkMain ,
            titleTextStyle: TextStyle(
            color: App.color.helperWhite
          ) ,
          contentTextStyle: TextStyle(
            color: App.color.helperWhite
          )
        ) ,
        timePickerTheme: const TimePickerThemeData() ,



      /// Widget
        textTheme: TextTheme(
          titleSmall: TextStyle(color: App.color.helperWhite , fontSize: 15.0),
          titleMedium: TextStyle(color: App.color.helperWhite , fontSize: 20.0),
          titleLarge: TextStyle(color: App.color.helperWhite , fontSize: 25.0),

          bodySmall: TextStyle(color: App.color.helperBlack,fontSize: 15.0) ,
          bodyMedium: TextStyle(color: App.color.helperBlack,fontSize: 17.0) ,
          bodyLarge: TextStyle(color: App.color.helperBlack,fontSize: 25.0) ,

          labelSmall: TextStyle(color: App.color.helperWhite,fontSize: 12.0) ,
          labelMedium: TextStyle(color: App.color.helperWhite,fontSize: 15.0) ,
          labelLarge: TextStyle(color: App.color.helperWhite,fontSize: 18.0) ,

          displaySmall: TextStyle(color: App.color.helperWhite,fontSize: 15.0),
          displayMedium: TextStyle(color: App.color.helperWhite,fontSize: 20.0),
          displayLarge: TextStyle(color: App.color.helperWhite,fontSize: 25.0),

          headlineSmall: TextStyle(color: App.color.helperWhite,fontSize: 15.0),
          headlineMedium: TextStyle(color: App.color.helperWhite,fontSize: 20.0),
          headlineLarge: TextStyle(color: App.color.helperWhite,fontSize: 25.0),

        ),
        cardTheme: CardTheme(
            color: App.color.darkFirst ,
          elevation: 10.0 ,
          shadowColor: App.color.darkFirst
        ) ,
        iconTheme: IconThemeData(
          color: App.color.darkMain ,
          size: 25.0
      ) ,
        listTileTheme: ListTileThemeData(
          tileColor: App.color.darkFirst ,
          textColor: App.color.helperWhite ,
          iconColor: App.color.helperWhite ,
      ) ,
        badgeTheme: BadgeThemeData(
          backgroundColor: App.color.darkMain ,
          textColor: App.color.helperWhite
        ) ,
        chipTheme: const ChipThemeData() ,
        dividerTheme: DividerThemeData(
          thickness: 1.5 ,
          color: App.color.helperWhite ,
          space: 1.0 ,
          indent: 0.0,
          endIndent: 0.0
        ) ,
        tooltipTheme: TooltipThemeData(
          triggerMode: TooltipTriggerMode.longPress ,
          padding: const EdgeInsets.all(5.0) ,
          textStyle: TextStyle(
            fontSize: 17.0 ,
            color: App.color.helperWhite
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0) ,
            color: App.color.grey.shade600 ,

          )
        ) ,
        inputDecorationTheme: InputDecorationTheme(
            // focusColor: App.color.darkMain ,
            // hoverColor: App.color.darkMain ,
            suffixIconColor: App.color.helperGrey600 ,
            prefixIconColor: App.color.helperGrey600 ,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: App.color.helperGrey600)
            ) ,
            hintStyle: TextStyle(color: App.color.helperGrey600),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: App.color.darkMain)
            )
        ) ,
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: App.color.darkFirst ,
          collapsedBackgroundColor: App.color.darkFirst ,
          textColor: App.color.helperWhite ,
          collapsedTextColor: App.color.helperWhite ,
          iconColor: App.color.helperWhite ,
          collapsedIconColor: App.color.helperWhite ,
          childrenPadding: const EdgeInsets.all(5.0) ,
        ) ,
        popupMenuTheme: const PopupMenuThemeData() ,
        textSelectionTheme: const TextSelectionThemeData(),
        colorScheme: ColorScheme(
            brightness: Brightness.dark ,
            primary: App.color.darkMain ,
            onPrimary: Colors.teal ,
            secondary: Colors.amber ,
            onSecondary: Colors.yellow ,
            surface: App.color.darkSecond ,
            onSurface: Colors.lime ,
            error: Colors.red ,
            onError: Colors.orange ,
            background: Colors.deepPurple ,
            onBackground: Colors.grey ,
        )
    );
  }



  @override
  ThemeData lightThemeData() {
    return ThemeData(
        useMaterial3: true ,
        brightness: Brightness.light ,
        primaryColor: App.color.lightMain ,
        scaffoldBackgroundColor: App.color.helperGrey300 ,
        canvasColor: App.color.lightMain ,
        highlightColor: App.color.lightMain.withOpacity(0.2),
        splashColor: App.color.lightMain.withOpacity(0.2) ,
        hoverColor: App.color.lightMain.withOpacity(0.2) ,
        disabledColor: App.color.lightMain.withOpacity(0.2) ,
        dividerColor: App.color.lightMain ,
        dialogBackgroundColor: App.color.helperWhite,
        unselectedWidgetColor: Colors.red, /// Test
        secondaryHeaderColor: Colors.red, /// Test


      /// Scaffold
        colorScheme: const ColorScheme.light(
          brightness: Brightness.light
        ) ,
        appBarTheme: AppBarTheme(
            backgroundColor: App.color.helperGrey300 ,
            foregroundColor: App.color.helperWhite ,
            elevation: 0 ,
            actionsIconTheme: IconThemeData(
                color: App.color.helperWhite ,
                size: 25.0
            )
        ) ,
        actionIconTheme: const ActionIconThemeData(),
        drawerTheme: DrawerThemeData(
          backgroundColor: App.color.helperWhite ,
          elevation: 0 ,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        ) ,
        tabBarTheme: const TabBarTheme() ,
        bottomAppBarTheme: const BottomAppBarTheme() ,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: App.color.helperWhite ,
          type: BottomNavigationBarType.fixed ,
          selectedItemColor: App.color.lightMain ,
          unselectedItemColor: App.color.grey
        ) ,
        navigationRailTheme: const NavigationRailThemeData() ,
        navigationBarTheme: const NavigationBarThemeData() ,
        navigationDrawerTheme: const NavigationDrawerThemeData() ,


      /// Alerts
        snackBarTheme: SnackBarThemeData(
          backgroundColor: App.color.lightMain ,
          //backgroundColor: App.color.generalGrey.shade300 ,
          elevation: 0 ,
          contentTextStyle: TextStyle(
              fontSize: 17.0 ,
              color: App.color.helperWhite
          ) ,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0) ,
                topRight: Radius.circular(10.0)
            ) ,
          )
      ) ,
        bannerTheme: MaterialBannerThemeData(
          backgroundColor: App.color.lightMain ,
          //surfaceTintColor: Colors.red ,
          dividerColor: App.color.helperWhite ,
          elevation: 5.0 ,
          shadowColor: App.color.lightMain,
          padding: const EdgeInsets.all(5.0),
          contentTextStyle: TextStyle(
            color: App.color.helperWhite ,
            fontSize: 17.0 ,
          )
      ) ,
        bottomSheetTheme: BottomSheetThemeData(
        //backgroundColor: App.color.darkMainColor,
        //modalBackgroundColor: Colors.red,
        backgroundColor: App.color.helperWhite ,
        surfaceTintColor: App.color.helperWhite ,
        elevation: 0 ,
      ) ,
        dialogTheme: DialogTheme(
          backgroundColor: App.color.helperWhite ,
          surfaceTintColor: App.color.helperWhite ,
          titleTextStyle: TextStyle(
              color: App.color.helperBlack ,
            fontWeight: FontWeight.bold
          ) ,
          contentTextStyle: TextStyle(
              color: App.color.helperBlack ,
              fontWeight: FontWeight.bold
          )
      ) ,
        timePickerTheme: const TimePickerThemeData() ,


      /// Button
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              iconSize: MaterialStateProperty.all(20.0) ,
              iconColor: MaterialStateProperty.all(App.color.lightMain) ,
              foregroundColor: MaterialStateProperty.all(App.color.lightMain) ,
              //backgroundColor: MaterialStateProperty.all(App.color.generalWhite) ,
            )
        ) ,
        filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(App.color.lightMain) ,
                foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite) ,
                iconColor: MaterialStateProperty.all(App.color.helperWhite)
            )
        ) ,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: App.color.lightMain ,
          foregroundColor: App.color.helperWhite
      ) ,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(App.color.lightMain) ,
                foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite)
            )
        ),
        applyElevationOverlayColor: true ,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(App.color.lightMain) ,
                foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite) ,
                iconColor: MaterialStateProperty.all(App.color.helperWhite)
            )
        ) ,
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(App.color.lightMain) ,
                foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite) ,
                side: MaterialStateProperty.all(BorderSide(color: App.color.helperWhite,width: 1.5)) ,
                iconColor: MaterialStateProperty.all(App.color.helperWhite)
            )
        ) ,
        menuButtonTheme: MenuButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(App.color.lightMain) ,
              foregroundColor: MaterialStateProperty.all<Color>(App.color.helperWhite) ,
              iconColor: MaterialStateProperty.all(App.color.helperWhite) ,


            )
        ) ,
        dropdownMenuTheme: const DropdownMenuThemeData() ,
        toggleButtonsTheme: const ToggleButtonsThemeData() ,
      //segmentedButtonTheme: const SegmentedButtonTheme(data: data, child: child),
      // SubmenuButton This Button is Important = DropDownButton


        /// Helper
        switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(App.color.lightMain),
            trackColor: MaterialStateProperty.all(App.color.grey.shade300) ,
          //thumbIcon: MaterialStateProperty.all(const Icon(Icons.circle_rounded)) ,
          overlayColor: MaterialStateProperty.all(App.color.lightMain)
        //splashRadius: 20

      ) ,
        checkboxTheme: CheckboxThemeData(
        splashRadius: 20.0 ,
        checkColor: MaterialStateProperty.all(App.color.helperWhite) ,
        fillColor: MaterialStateProperty.all(App.color.lightMain) ,
        overlayColor: MaterialStateProperty.all(App.color.lightMain) ,
        side: BorderSide(color: App.color.lightMain,width: 1.5) ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)) ,
      ) ,
        radioTheme: RadioThemeData(
        splashRadius: 20.0 ,
        fillColor: MaterialStateProperty.all(App.color.lightMain) ,
        overlayColor: MaterialStateProperty.all(App.color.lightMain) ,
      ) ,
        sliderTheme: SliderThemeData(
        thumbColor: App.color.lightMain ,
        activeTickMarkColor: Colors.red ,
        activeTrackColor: App.color.lightMain ,
        overlayColor: App.color.lightMain ,
        inactiveTrackColor: App.color.grey.shade400,
      ) ,
        progressIndicatorTheme: ProgressIndicatorThemeData(
        color: App.color.lightMain,
        linearTrackColor: App.color.grey.shade400 ,
        circularTrackColor: App.color.grey.shade400 ,
        refreshBackgroundColor: App.color.helperWhite ,
        linearMinHeight: 5.0 ,
      ) ,

        /// Widgets
        textTheme: TextTheme(
          titleSmall: TextStyle(color: App.color.helperWhite , fontSize: 15.0),
          titleMedium: TextStyle(color: App.color.helperWhite , fontSize: 20.0),
          titleLarge: TextStyle(color: App.color.helperWhite , fontSize: 25.0),

          bodySmall: TextStyle(color: App.color.helperBlack,fontSize: 15.0) ,
          bodyMedium: TextStyle(color: App.color.helperBlack,fontSize: 17.0) ,
          bodyLarge: TextStyle(color: App.color.helperBlack,fontSize: 25.0) ,

          labelSmall: TextStyle(color: App.color.helperWhite,fontSize: 12.0) ,
          labelMedium: TextStyle(color: App.color.helperWhite,fontSize: 15.0) ,
          labelLarge: TextStyle(color: App.color.helperWhite,fontSize: 18.0) ,

          displaySmall: TextStyle(color: App.color.helperBlack,fontSize: 15.0),
          displayMedium: TextStyle(color: App.color.helperBlack,fontSize: 20.0),
          displayLarge: TextStyle(color: App.color.helperBlack,fontSize: 25.0),

          headlineSmall: TextStyle(color: App.color.helperWhite,fontSize: 15.0),
          headlineMedium: TextStyle(color: App.color.helperWhite,fontSize: 20.0),
          headlineLarge: TextStyle(color: App.color.helperWhite,fontSize: 25.0),

        ),
        cardTheme: CardTheme(
            color: App.color.helperWhite ,
        elevation: 5.0 ,
        shadowColor: App.color.helperBlack
        ) ,
        iconTheme: IconThemeData(
          color: App.color.lightMain ,
          size: 25.0
      ) ,
        listTileTheme: ListTileThemeData(
        tileColor: App.color.grey.shade100,
            textColor: App.color.helperBlack ,
            iconColor: App.color.helperBlack ,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(100.0)
            // )
        ) ,
        badgeTheme: BadgeThemeData(
            backgroundColor: App.color.lightMain ,
            textColor: App.color.helperWhite
        ) ,
        chipTheme: const ChipThemeData() ,
        dividerTheme: DividerThemeData(
            thickness: 1.5 ,
            color: App.color.lightMain ,
            space: 1.0 ,
            indent: 0.0,
            endIndent: 0.0
        ) ,
        tooltipTheme: TooltipThemeData(
            triggerMode: TooltipTriggerMode.longPress ,
            padding: const EdgeInsets.all(5.0) ,
            textStyle: TextStyle(
                fontSize: 17.0 ,
                color: App.color.helperWhite
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0) ,
              color: App.color.grey.shade600 ,

            )
        ) ,
        inputDecorationTheme: InputDecorationTheme(
          focusColor: App.color.lightMain ,
          hoverColor: App.color.lightMain ,

          prefixIconColor: App.color.helperBlack,
          suffixIconColor: App.color.helperBlack,

          filled: true ,
          fillColor: App.color.helperGrey200,

          hintStyle: TextStyle(color: App.color.helperGrey600),

          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: App.color.helperTransparent)
          )
      ) ,
        popupMenuTheme: const PopupMenuThemeData() ,
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: App.color.lightMain ,
          collapsedBackgroundColor: App.color.lightMain ,
          textColor: App.color.helperWhite ,
          collapsedTextColor: App.color.helperWhite ,
          iconColor: App.color.helperWhite ,
          collapsedIconColor: App.color.helperWhite ,
          childrenPadding: const EdgeInsets.all(5.0) ,
        )
    );
  }

  /*
  dropdownMenuTheme: const DropdownMenuThemeData(),
  MenuBarThemeData? menuBarTheme,
  MenuButtonThemeData? menuButtonTheme,
  MenuThemeData? menuTheme,
  NavigationBarThemeData? navigationBarTheme,
  NavigationDrawerThemeData? navigationDrawerTheme,
  NavigationRailThemeData? navigationRailTheme,
  PopupMenuThemeData? popupMenuTheme,
  TextSelectionThemeData? textSelectionTheme,
  SegmentedButtonThemeData? segmentedButtonTheme,
  ToggleButtonsThemeData? toggleButtonsTheme,
*/
}