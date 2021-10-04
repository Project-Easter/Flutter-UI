import 'package:books_app/constants/routes.dart';
import 'package:books_app/main.dart';
import 'package:books_app/screens/add_book.dart';
import 'package:books_app/screens/auth/confirm_email.dart';
import 'package:books_app/screens/auth/forgot_password.dart';
import 'package:books_app/screens/auth/login.dart';
import 'package:books_app/screens/auth/register.dart';
import 'package:books_app/screens/bookshelf.dart';
import 'package:books_app/screens/dashboard/dashboard.dart';
import 'package:books_app/screens/home.dart';
import 'package:books_app/screens/initial_screen.dart';
import 'package:books_app/screens/more.dart';
import 'package:books_app/screens/profile/edit_profile.dart';
import 'package:books_app/screens/profile/otp_verification.dart';
import 'package:books_app/screens/profile/verify_mobile.dart';
import 'package:books_app/screens/settings_screens.dart';
import 'package:books_app/services/user_location.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.INITIAL_PAGE:
        return MaterialPageRoute<dynamic>(builder: (_) => InitialScreen());
      case Routes.EDIT_PROFILE:
        return MaterialPageRoute<dynamic>(builder: (_) => EditProfile());
      case Routes.LOGIN:
        return MaterialPageRoute<dynamic>(builder: (_) => LoginScreen());
      case Routes.REGISTER:
        return MaterialPageRoute<dynamic>(builder: (_) => RegisterScreen());
      case Routes.ABOUT_US:
        return MaterialPageRoute<dynamic>(builder: (_) => AboutUs());
      case Routes.PRIVACY_POLICY:
        return MaterialPageRoute<dynamic>(builder: (_) => PrivacyPolicy());
      case Routes.TERMS_CONDITION:
        return MaterialPageRoute<dynamic>(builder: (_) => TermsCondition());
      case Routes.CONFIRM_EMAIL:
        return MaterialPageRoute<dynamic>(
            builder: (_) =>
                ConfirmEmailScreen(email: settings.arguments as String));
      case Routes.DASHBOARD:
        return MaterialPageRoute<dynamic>(builder: (_) => DashboardPage());
      case Routes.FORGOT_PASSWORD:
        return MaterialPageRoute<dynamic>(
            builder: (_) => ForgotPasswordScreen());
      case Routes.ADD_BOOK:
        return MaterialPageRoute<dynamic>(builder: (_) => const AddBook());
      case Routes.HOME:
        return MaterialPageRoute<dynamic>(builder: (_) => Home());
      case Routes.SETTINGS:
        return MaterialPageRoute<dynamic>(builder: (_) => SettingsScreen());
      case Routes.LOCATION:
        return MaterialPageRoute<dynamic>(builder: (_) => GetLocation());
      case Routes.LIBRARY:
        return MaterialPageRoute<dynamic>(builder: (_) => LibraryPage());
      case Routes.WRAPPER:
        return MaterialPageRoute<dynamic>(builder: (_) => Wrapper());
      // case Routes.VERIFY_MOBILE:
      //   return MaterialPageRoute<dynamic>(builder: (_) => const EnterMobile());
      // case Routes.OTP:
      //   return MaterialPageRoute<dynamic>(builder: (_) => EnterOtp());

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
