/// App api endpoints are defined here
class ApiClient {
  ApiClient._();

  ///Staging Url
  //static const String apiBaseUrl = "https://mozmais.net/soft_plus/api/";

  ///Production Url
  //static const String apiBaseUrl = "https://ngprojects.in/soft_plus/api/";d
  static const String apiBaseUrl = "https://beurs.in/soft_plus/api/";

  static const String signIn = "UserMaster/CheckLoginData";
  static const String socialSignIn = "UserMaster/SocialLogin";
  static const String signUp = "UserMaster/RegisterNewUser";
  static const String forgotPassword = "UserMaster/ForgotPassword";
  static const String loginWithOtp = "UserMaster/login_with_otp";
  static const String numberVerifyOtp = "UserMaster/verify_otp";
  static const String otpVerification = "UserMaster/VerifyUserOTP";
  static const String resetPassword = "UserMaster/ChangePassword";
  static const String getSubscriptionPlan =
      "CommonMaster/GetSubscrTemplateList";
  static const String getSubscriptionCount =
      "UserMaster/getUserSubcriptionCount";
  static const String getUserProfile = "UserMaster/getUserProfile";
  static const String updateProfile = "UserMaster/UpdateUserProfile";
  static const String faq = "CommonMaster/GetFAQTemplateList";
  static const String review = "UserMaster/AddUserReview";
  static const String contactUs = "UserMaster/AddContactUs";
  static const String getPastWishes = "UserMaster/GetPastWishesList";
  static const String getUpComingWish = "UserMaster/GetUpcomingBDayList";
  static const String getTemplate = "CommonMaster/GetWishTemplateList";
  static const String addPayment = "UserMaster/PurchasedSubscription";
  static const String sendMessageTemplate = "UserMaster/SendWishes";
  static const String contactSync = "UserMaster/SyncContact";
  static const String privacyPolicy = "UserMaster/GetPrivacyPolicy";
  static const String termsConditions = "UserMaster/GetTermsCondition";
  static const String getFaq = "UserMaster/GetFaq";
  static const String getAboutUs = "UserMaster/GetAboutUs";
  static const String getDeleteUser = "UserMaster/deleteUser";
}
