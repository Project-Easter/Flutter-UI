import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/util/theme_notifier.dart';
import 'package:books_app/util/values/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:books_app/Router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/books.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then(
    (prefs) {
      runApp(
        MultiProvider(
          providers: [
            //Stream from Firebase
            // StreamProvider<MyAppUser>.value(value: AuthService().user),
            //Theme
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier(darkTheme),
            ),
            //**AppWide Data From Model
            ChangeNotifierProvider(
              create: (_) => Books(),
            ),
          ],
          child: MyApp(),
        ),
      );
    },
  );
}
//TODO:Create a singleton class and use that as global variable instead of making a new Authservice instancee and getting the UID and passing that to DatabaseService..

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final myAppUser = _authService.currentUserFromFireBase;
    return MaterialApp(
      // theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
      title: "Explr", //This is shown when the app is minimized
      initialRoute: myAppUser == null ? startupPage : home,
      // initialRoute: startupPage,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
