import 'package:books_app/common/themes.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/models/books.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/utils/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:books_app/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
