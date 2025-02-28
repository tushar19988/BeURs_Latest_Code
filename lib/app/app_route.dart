import 'package:beurs/ui/about_us/binding/about_us_binding.dart';
import 'package:beurs/ui/about_us/view/about_us_screen.dart';
import 'package:beurs/ui/contact_us_screen/binding/contact_us_binding.dart';
import 'package:beurs/ui/contact_us_screen/view/contact_us_screen.dart';
import 'package:beurs/ui/create_profile_screen/binding/create_profile_binding.dart';
import 'package:beurs/ui/create_profile_screen/view/create_profile_view.dart';
import 'package:beurs/ui/dashboard_screen/binding/dashboard_binding.dart';
import 'package:beurs/ui/dashboard_screen/view/dashboard_screen.dart';
import 'package:beurs/ui/dashboard_screen/view/profile_screen/profile_screen.dart';
import 'package:beurs/ui/faq/binding/faq_binding.dart';
import 'package:beurs/ui/faq/view/faq_screen.dart';
import 'package:beurs/ui/forgot_password_screen/binding/forgot_password_binding.dart';
import 'package:beurs/ui/forgot_password_screen/view/forgot_password_screen.dart';
import 'package:beurs/ui/login_otp/login_number.dart';
import 'package:beurs/ui/login_otp/login_number_controller.dart';
import 'package:beurs/ui/login_screen/binding/login_binding.dart';
import 'package:beurs/ui/login_screen/view/login_screen.dart';
import 'package:beurs/ui/notification_screen/binding/notification_binding.dart';
import 'package:beurs/ui/notification_screen/view/notification_screen.dart';
import 'package:beurs/ui/otp_verification_screen/binding/otp_verification_binding.dart';
import 'package:beurs/ui/otp_verification_screen/view/otp_verification_screen.dart';
import 'package:beurs/ui/privacy_policy_screen/binding/privacy_policy_binding.dart';
import 'package:beurs/ui/privacy_policy_screen/view/privacy_policy_screen.dart';
import 'package:beurs/ui/reset_passwrod_screen/binding/reset_password_binding.dart';
import 'package:beurs/ui/reset_passwrod_screen/view/reset_password_screen.dart';
import 'package:beurs/ui/review_screen/binding/review_binding.dart';
import 'package:beurs/ui/review_screen/view/review_screen.dart';
import 'package:beurs/ui/sign_up_screen/binding/sign_up_binding.dart';
import 'package:beurs/ui/sign_up_screen/view/sign_up_screen.dart';
import 'package:beurs/ui/splash_screen/binding/splash_binding.dart';
import 'package:beurs/ui/splash_screen/view/splash_screen.dart';
import 'package:beurs/ui/terms_conditions_screen/binding/term_condition_binding.dart';
import 'package:beurs/ui/terms_conditions_screen/view/term_condition_screen.dart';
import 'package:beurs/ui/walkthrough/binding/walkthrough_binding.dart';
import 'package:beurs/ui/walkthrough/view/walkthrough_view.dart';
import 'package:beurs/ui/webview/binding/webview_binding.dart';
import 'package:beurs/ui/webview/view/webview_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const walkThroughPage = '/walk_through_page';
  static const loginPage = '/login_page';
  static const signUpPage = '/sign_up_page';
  static const profilePage = '/profile_page';
  static const forgotPasswordPage = '/forgot_password_page';
  static const otpVerificationPage = '/otp_verification_page';
  static const resetPasswordPage = '/reset_password_page';
  static const dashboardPage = '/dashboard_page';
  static const notificationPage = '/notification_page';
  // static const privacyPolicyPage = '/privacy_policy_page';
  // static const termConditionPage = '/term_condition_page';
  static const aboutUs = '/about_us';
  // static const faqPage = '/faq_page';
  static const reviewPage = '/review_page';
  static const contactUsPage = '/contact_us_page';
  static const webViewPage = '/web_view_page';
  static const createProfilePage = '/create_profile';
  static const privacyPolicy = '/privacy_policy';
  static const faq = '/faq';
  static const termsConditions = '/terms_conditions';
  static const loginNumber = '/login_number';

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.initialRoute,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.walkThroughPage,
      page: () => const WalkthroughPage(),
      binding: WalkBinding(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signUpPage,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.profilePage,
      page: () => const ProfileScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordPage,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerificationPage,
      page: () => const OTPVerificationScreen(),
      binding: OTPVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPasswordPage,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboardPage,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.notificationPage,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.reviewPage,
      page: () => const ReviewScreen(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: AppRoutes.loginNumber,
      page: () => PhoneNumberScreen(),
      binding: LoginNumberBinding(),
    ),
    GetPage(
      name: AppRoutes.contactUsPage,
      page: () => const ContactUsScreen(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: AppRoutes.webViewPage,
      page: () => const WebViewPage(),
      binding: WebViewBinding(),
    ),
    GetPage(
      name: AppRoutes.createProfilePage,
      page: () => const CreateProfileScreen(),
      binding: CreateProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: AppRoutes.termsConditions,
      page: () => const TermConditionScreen(),
      binding: TermConditionBinding(),
    ),
    GetPage(
      name: AppRoutes.faq,
      page: () => const FaqScreen(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: AppRoutes.aboutUs,
      page: () => const AboutUsScreen(),
      binding: AboutUsBinding(),
    ),
  ];
}
