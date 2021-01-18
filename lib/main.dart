import 'package:books_app/screens/login.dart';
import 'package:books_app/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Book Club", //This is shown when the app is minimized
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:bookTheme(),
      home: Scaffold(        
        body: Center(
          child: Container(
            child: LoginScreen(),
          ),
        ),
      ),
    );
  }
}
