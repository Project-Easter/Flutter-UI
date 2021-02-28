import 'package:books_app/Constants/routes.dart';
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
  SharedPreferences.getInstance().then((prefs) {
    runApp(ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(darkTheme), child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ChangeNotifierProvider(
        create: (_) => Books(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Explr", //This is shown when the app is minimized
          initialRoute: startupPage,
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
