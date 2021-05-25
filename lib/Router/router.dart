import 'package:flutter/material.dart';

import '../Constants/routes.dart';
import '../Models/user.dart';
import '../Screens/Auth/confirm_email.dart';
import '../Screens/Auth/forgot_password.dart';
import '../Screens/Auth/login.dart';
import '../Screens/Auth/register.dart';
import '../Screens/Chat/message_screen.dart';
import '../Screens/Profile/edit_profile.dart';
import '../Screens/add_book.dart';
import '../Screens/bookshelf.dart';
import '../Screens/chat_screen.dart';
import '../Screens/dashboard/Dashboard.dart';
import '../Screens/home.dart';
import '../Screens/initial_screen.dart';
import '../Screens/settings_screens.dart';
import '../Services/user_location.dart';

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
        return MaterialPageRoute<dynamic>(builder: (_) => AddBook());
      case Routes.HOME:
        return MaterialPageRoute<dynamic>(builder: (_) => Home());
      case Routes.LOCATION:
        return MaterialPageRoute<dynamic>(builder: (_) => GetLocation());
      case Routes.CHAT:
        return MaterialPageRoute<dynamic>(builder: (_) => ChatScreen());
      case Routes.SETTINGS:
        return MaterialPageRoute<dynamic>(builder: (_) => SettingsScreen());
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
