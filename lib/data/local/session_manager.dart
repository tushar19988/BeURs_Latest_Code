import 'package:get_storage/get_storage.dart';

/// Storage manager to store and retrieve data from local storage
class StorageManager {
  static final StorageManager _instance = StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  final String authToken = 'auth_token';
  final String themeType = 'theme_type';
  final String fromFresh = 'from_fresh';
  final String email = 'userEmail';
  final String userId = 'userId';
  final String fullName = 'full_name';
  final String userImage = 'userImage';
  final String isShowInfoPopUp = 'is_show_info_popup';
  final String isSubscription = 'is_user_subscription';

  GetStorage localStorage = GetStorage();

  /// Set auth token after login-signup
  void setAuthToken(String token) {
    localStorage.write(authToken, token);
  }

  String? getAuthToken() {
    return localStorage.read(authToken);
  }

  /// Set user email
  void setEmail(String userEmail) {
    localStorage.write(email, userEmail);
  }

  String? getEmail() {
    return localStorage.read(email);
  }

  /// Set user email
  void setInfoPopUp(bool value) {
    localStorage.write(isShowInfoPopUp, value);
  }

  bool? getInfoPopUp() {
    return localStorage.read(isShowInfoPopUp);
  }

  /// Set user subscription
  void setUserSubscription(bool value) {
    localStorage.write(isSubscription, value);
  }

  bool? getUserSubscription() {
    return localStorage.read(isSubscription);
  }
  /// Set user ID
  void setUserId(String id) {
    localStorage.write(userId, id);
  }

  String? getUserId() {
    return localStorage.read(userId);
  }

  /// Set user name
  void setName(String userName) {
    localStorage.write(fullName, userName);
  }

  String? getName() {
    return localStorage.read(fullName);
  }

  /// Set user image
  void setUserImage(String userImg) {
    localStorage.write(userImage, userImg);
  }

  String? getUserImage() {
    return localStorage.read(userImage);
  }

  /// Set state fro user come fresh app install
  void setFromFresh(bool isFromFresh) {
    localStorage.write(fromFresh, isFromFresh);
  }

  bool? getFromFresh() {
    return localStorage.read(fromFresh);
  }

  /// Set Device Theme Mode

  void setThemeType(bool themeMode) {
    localStorage.write(themeType, themeMode);
  }

  bool? getThemeType() {
    return localStorage.read(themeType);
  }

  /// Clear all data stored in local
  void clearSession() {
    localStorage.erase();
  }
}
