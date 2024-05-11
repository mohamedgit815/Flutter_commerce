import 'package:commerce/App/Helper/dio_helper.dart';
import 'package:commerce/App/Helper/firebase_fcm.dart';
import 'package:commerce/App/Helper/global_helper.dart';
import 'package:commerce/App/Helper/localization_helper.dart';
import 'package:commerce/App/Helper/payments.dart';
import 'package:commerce/App/Helper/save_profile.dart';
import 'package:commerce/App/Services/GoogleMap/google_map_service.dart';
import 'package:commerce/App/Utils/app_colors.dart';
import 'package:commerce/App/Utils/app_strings.dart';
import 'package:commerce/App/Utils/app_themes.dart';
import 'package:commerce/App/Utils/geo_locator.dart';
import 'package:commerce/App/Utils/navigator.dart';
import 'package:commerce/App/Utils/regular_expressions.dart';
import 'package:commerce/App/Widgets/alerts_widgets.dart';
import 'package:commerce/App/Widgets/buttons_widgets.dart';
import 'package:commerce/App/Widgets/global_widgets.dart';
import 'package:commerce/App/Widgets/packages_widgets.dart';
import 'package:commerce/App/Widgets/text_widgets.dart';


class App {
  static final GoogleMapService map = GoogleMapService();
  static final SaveProfile profile = SaveProfile();
  static final AppStrings strings = AppStrings(); // AppStrings
  static final AppColor color = AppColor(); // Colors
  static final RegularExpression regExp = RegularExpression(); // RegularExpression
  static final BaseAppNavigator navigator = AppNavigator(); // Navigator.
  static final BaseAppValidator validator = AppValidator(); // Validator.
  static final BaseAppThemes theme = AppThemes(); // Themes
  static final BaseAlertWidgets alertWidgets = AlertWidgets(); // AlertWidgets
  static final BasePackagesWidgets packageWidgets = PackagesWidgets(); // Packages Widgets
  static final BaseGlobalWidgets globalWidgets = GlobalWidgets(); // GlobalWidgets
  static final BaseButtonsWidgets buttons = ButtonsWidgets(); // Every Buttons
  static final BaseTextWidgets text = TextWidget(); // Every Text Widgets
  static final BaseLocalizationHelper localization = LocalizationHelper(); // Localization
  static final BaseGlobalHelper global = GlobalHelper();
  static final DioHelper dio = DioHelper();
  static final BaseFirebaseFCM fcm = FirebaseFCM();
  static final BaseGeoLocatorHelper location = GeoLocatorHelper();
  static final BasePayments payments = Payments();
  //static final BaseFireBase firebase = FireBase();
}

