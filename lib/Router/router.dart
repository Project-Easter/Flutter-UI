import 'package:books_app/Screens/Auth/login.dart';
<<<<<<< HEAD
import 'package:books_app/Screens/add_book.dart';
=======
import 'package:books_app/Screens/Profile/public_profile.dart';
>>>>>>> e68656718869e9e87508702cd6df69e8ad013060
import 'package:books_app/Screens/home.dart';
import 'package:books_app/Screens/initial_screen.dart';
import 'package:books_app/Widgets/UserLocation.dart';
import 'package:flutter/material.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Screens/Auth/confirmOTP.dart';
import 'package:books_app/Screens/Auth/register.dart';
import 'package:books_app/Screens/Auth/signup.dart';
import 'package:books_app/Screens/Auth/confirmemail.dart';
import 'package:books_app/Screens/Dashboard.dart';
import 'package:books_app/Screens/Auth/ResetPassword.dart';
import 'package:books_app/Screens/Auth/ForgotPassword.dart';
import 'package:books_app/Screens/Library_Page/library_page.dart';
import 'package:books_app/Screens/Explore_Nearby/explore_page.dart';
import 'package:books_app/Screens/Profile/private_profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startupPage:
        return MaterialPageRoute(builder: (_) => InitialScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case confirmOTP:
        return MaterialPageRoute(
            builder: (_) => ConfirmScreen(settings.arguments));
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case userName:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case confirmEmail:
        return MaterialPageRoute(builder: (_) => ConfirmEmailScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
<<<<<<< HEAD
      case addBook:
        return MaterialPageRoute(builder: (_) => AddBook());
=======
      case libraryPage:
        return MaterialPageRoute(builder: (_) => LibraryPage());
      case exploreNearby:
        return MaterialPageRoute(builder: (_) => ExplorePage());
      case publicProfile:
        return MaterialPageRoute(builder: (_) => PublicProfile());
      case privateProfile:
        return MaterialPageRoute(builder: (_) => PrivateProfile());
>>>>>>> e68656718869e9e87508702cd6df69e8ad013060
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case location:
        return MaterialPageRoute(builder: (_) => GetLocation());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
