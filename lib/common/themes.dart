import 'package:books_app/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
   floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: blueButton,
   
  ),
  primarySwatch: Colors.grey,
  textTheme: Typography(platform: defaultTargetPlatform).white,
  primaryColor: Colors.white,
  primaryTextTheme: TextTheme(
    headline6: GoogleFonts.muli(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(18, 19, 33, 1),
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    foregroundColor: Colors.white,
    shadowColor: Colors.white54,
  ),
  // brightness: Brightness.dark,
  backgroundColor: const Color.fromRGBO(18, 19, 33, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(18, 19, 33, 1),
  colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey[900],
      onSecondary: blueButton),
  // accentIconTheme: const IconThemeData(color: Colors.black),
  dividerColor: Colors.transparent,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: const Color(0xff181926),
    ),
  ),
);

final ThemeData lightTheme = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: blueButton,
    
   
  ),
  textTheme: Typography(platform: defaultTargetPlatform).black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE5E5E5),
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
    foregroundColor: Colors.black,
    shadowColor: Colors.grey,

    // titleTextStyle: GoogleFonts.muli(
    //   // fontSize: 10,
    //   color: Colors.black,
    // ),
  ),
  primaryTextTheme: TextTheme(
    headline6: GoogleFonts.muli(color: Colors.black),
  ),
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  scaffoldBackgroundColor: const Color(0xFFE5E5E5),
  colorScheme: const ColorScheme.dark(
    
      brightness: Brightness.light,
      primary: Colors.black,
      secondary: Colors.grey,
      onSecondary: greenButton),
  // accentIconTheme: const IconThemeData(color: Colors.white),
  dividerColor: Colors.transparent,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xff181926),
      onPrimary: Colors.white,
    ),
  ),
);

ThemeData bookTheme() {
  TextTheme _bookTextTheme(TextTheme base) {
    return base.copyWith(
        headline4: base.headline4.copyWith(
            fontFamily: 'Poppins',
            fontSize: 36.0,
            color: const Color.fromRGBO(24, 25, 38, 1)),
        bodyText1: base.bodyText1.copyWith(
          fontFamily: 'Poppins',
          fontSize: 16.0,
          color: Colors.white10,
        ));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _bookTextTheme(base.textTheme),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color.fromRGBO(36, 107, 253, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
    //Textfield frames
    inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 25, 38, 1), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 25, 38, 1), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)))),
  );
}
