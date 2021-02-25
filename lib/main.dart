import 'package:books_app/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:books_app/Router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Models/books.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Books(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Book Club", //This is shown when the app is minimized
        initialRoute: startupPage,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Explr", //This is shown when the app is minimized
      initialRoute: startupPage,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
