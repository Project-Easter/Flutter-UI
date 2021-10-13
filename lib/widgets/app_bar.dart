import 'package:books_app/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
AppBar MyAppBar(BuildContext buildContext) {
  return AppBar(
    // shadowColor: Colors.black,
    bottomOpacity: 0.5,
    titleSpacing: 5,
    elevation: 0.0,
    // backgroundColor: Theme.of(buildContext).backgroundColor,
    leading: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Image.asset('assets/images/ExplrLogo(150x150).png'),
    ),
    title: Text(
      'Explr',
      style: GoogleFonts.muli(),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.settings,
          // color: Colors.black,
          size: 20,
        ),
        onPressed: () {
          Navigator.pushNamed(buildContext, Routes.SETTINGS);
        },
      ),
    ],
  );
}
