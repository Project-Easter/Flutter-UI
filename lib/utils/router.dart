import 'package:books_app/Screens/Auth/confirm_email.dart';
import 'package:books_app/Screens/Profile/edit_profile.dart';
import 'package:books_app/Screens/bookshelf.dart';
import 'package:books_app/Screens/initial_screen.dart';
import 'package:books_app/Screens/settings_screens.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/screens/add_book.dart';
import 'package:books_app/screens/auth/forgot_password.dart';
import 'package:books_app/screens/auth/login.dart';
import 'package:books_app/screens/auth/register.dart';
import 'package:books_app/screens/chat/message_screen.dart';
import 'package:books_app/screens/chat/wrapper.dart';
import 'package:books_app/screens/dashboard/dashboard.dart';
import 'package:books_app/screens/home.dart';
import 'package:books_app/screens/more.dart';
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
      case Routes.CHAT:
        return MaterialPageRoute<dynamic>(builder: (_) => const Wrapper());
      case Routes.SETTINGS:
        return MaterialPageRoute<dynamic>(builder: (_) => SettingsScreen());
        case Routes.LOCATION:
        return MaterialPageRoute<dynamic>(builder: (_) => GetLocation());
      case Routes.LIBRARY:
        return MaterialPageRoute<dynamic>(builder: (_) => LibraryPage());
      case Routes.MESSAGE:
        return MaterialPageRoute<dynamic>(
            builder: (_) => MessageScreen(
                  receiver: settings.arguments as UserData,
                ));

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
