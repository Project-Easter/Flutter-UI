import 'package:flutter/material.dart';

ThemeData bookTheme() {
  TextTheme _bookTextTheme(TextTheme base) {
    return base.copyWith(
        headline4: base.headline4.copyWith(fontFamily: 'Poppins', fontSize: 36.0, color: Color.fromRGBO(24, 25, 38, 1)),
        bodyText1: base.bodyText1.copyWith(
          fontFamily: 'Poppins',
          fontSize: 16.0,
          color: Colors.white10,
        ));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    //Text themes
    textTheme: _bookTextTheme(base.textTheme),

    //Buttons
    buttonColor: Color.fromRGBO(36, 107, 253, 1),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
    //Textfield frames
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(24, 25, 38, 1), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(24, 25, 38, 1), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)))),
  );
}
