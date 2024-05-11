class AppStrings {
  final String mainUrl = "http://192.168.1.20:8000";
  final String baseUrl = "http://192.168.1.20:8000/api/v1";
  final String registerUrl = "/auth/Register";
  final String loginUrl = "/auth/";
  final String updateProfileUrl = "/auth/";
  final String allProductUrl = "/product";
  final String productExistUrl= "/product/exist";
  final String productAndCategory = "/product/category";
  final String getAllCategory = "/category/all/";
  final String searchProduct = "/product/search";
  final String addToCart = "/cart";
  final String countAndTotal = "/cart/count";
  final String cartAndAll = "/cart/all";
  final String order = "/order";
  final String adminOrder = "/order/other";

  final String icon = 'assets/images/icon.png';

  /// Add Here Name Languages
  final String arabic = 'عربي';
  final String english = "English";


  /// SnackBar
  final String createScreenSuccess = 'Created';
  final String createScreenError = 'is Empty';
  final String homeScreenDeleted = 'Item is Deleted';
  final String updateSuccess = "Item Updated";
  final String updateError = "Error";


  /// Alert Dialog
  final String saveDialog = "Do you want to Save ?";
  final String deleteDialog = "You will delete Item ?";
  final String sureDialog = "Are you sure ?";


  /// AppBar Text
  final String appbarHomeScreen = "Home Screen";
  final String appbarCreateScreen = "Create Screen";
  final String appbarUpdateScreen = "Update Screen";
}