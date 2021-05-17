import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Utils/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:books_app/Router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Common/Themes.dart';
import 'Models/books.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then(
    (prefs) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier(darkTheme),
            ),
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

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final myAppUser = _authService.currentUserFromFireBase;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Explr",
      initialRoute: myAppUser == null ? Routes.INITIAL_PAGE : Routes.HOME,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
