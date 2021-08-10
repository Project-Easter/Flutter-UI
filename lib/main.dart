import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/Utils/router.dart';
import 'package:books_app/common/themes.dart';
import 'package:books_app/providers/books.dart';
import 'package:books_app/providers/theme.dart';
import 'package:books_app/providers/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then(
    (SharedPreferences prefs) {
      runApp(
        MultiProvider(
          providers: <ChangeNotifierProvider<dynamic>>[
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier(lightTheme),
            ),
            ChangeNotifierProvider<Books>(
              create: (_) => Books(),
            ),
            ChangeNotifierProvider<UserModel>(
              create: (_) => UserModel(),
            )
          ],
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic myAppUser = AuthService().currentUserFromFireBase;
    return MaterialApp(
      theme: Provider.of<ThemeNotifier>(context).getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Explr',
      initialRoute: myAppUser == null ? Routes.INITIAL_PAGE : Routes.HOME,
      onGenerateRoute: RouteGenerator.generateRoute,
      //})
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Explr',
    //   initialRoute: myAppUser == null ? Routes.INITIAL_PAGE : Routes.HOME,
    //   onGenerateRoute: RouteGenerator.generateRoute,
    // );
  }
}
