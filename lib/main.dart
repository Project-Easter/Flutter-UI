import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/routes.dart';
import 'Models/books.dart';
import 'Router/router.dart';
import 'Services/auth.dart';
import 'Utils/theme_notifier.dart';
import 'Utils/values/theme_switch.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then(
    (SharedPreferences prefs) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier(darkTheme),
            ),
            ChangeNotifierProvider<Books>(
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
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dynamic myAppUser = _authService.currentUserFromFireBase;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explr',
      initialRoute: myAppUser == null ? Routes.INITIAL_PAGE : Routes.HOME,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
