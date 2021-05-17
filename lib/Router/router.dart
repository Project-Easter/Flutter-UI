import 'package:books_app/Screens/bookshelf.dart';
import 'package:books_app/Screens/Chat/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:books_app/Screens/Auth/Login.dart';
import 'package:books_app/Screens/add_book.dart';
import 'package:books_app/Screens/home.dart';
import 'package:books_app/Screens/initial_screen.dart';
import 'package:books_app/Services/UserLocation.dart';
import 'package:books_app/Screens/chat_screen.dart';
import 'package:books_app/Screens/settings_screens.dart';
import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Screens/Auth/Register.dart';
import 'package:books_app/Screens/dashboard/Dashboard.dart';
import 'package:books_app/Screens/Auth/ForgotPassword.dart';
import 'package:books_app/Screens/Profile/edit_profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.INITIAL_PAGE:
        return MaterialPageRoute(builder: (_) => InitialScreen());
      case Routes.EDIT_PROFILE:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case Routes.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.REGISTER:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.DASHBOARD:
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case Routes.FORGOT_PASSWORD:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.ADD_BOOK:
        return MaterialPageRoute(builder: (_) => AddBook());
      case Routes.HOME:
        return MaterialPageRoute(builder: (_) => Home());
      case Routes.LOCATION:
        return MaterialPageRoute(builder: (_) => GetLocation());
      case Routes.CHAT:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case Routes.SETTINGS:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case Routes.LIBRARY:
        return MaterialPageRoute(builder: (_) => LibraryPage());
      case Routes.MESSAGE:
        return MaterialPageRoute(
            builder: (_) => MessageScreen(
                  receiver: settings.arguments,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
