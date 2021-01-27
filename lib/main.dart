import 'package:books_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:books_app/Router/router.dart';
import 'package:books_app/Services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Book Club", //This is shown when the app is minimized
      home: AuthService().handleAuth(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
