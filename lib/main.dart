import 'package:flutter/material.dart';
import 'package:books_app/screens/login/login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Book Club", //This is shown when the app is minimized
    home: LoginScreen(),
  ));
}
