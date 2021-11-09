import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
AppBar MyAppBar(BuildContext buildContext) {
  return AppBar(
    bottomOpacity: 0.5,
    titleSpacing: 5,
    elevation: 0.0,
    leading: Consumer<UserData?>(
        builder: (BuildContext context, UserData? userdata, _) {
      if (userdata != null) {
        if (userdata.photoURL!.startsWith('assets')) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/images/ExplrLogo(150x150).png',
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userdata.photoURL!,
              ),
            ),
          );
        }
      } else
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        );
    }),
    title: Text(
      'Explr',
      style: GoogleFonts.lato(),
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.settings,
          size: 20,
        ),
        onPressed: () {
          Navigator.pushNamed(buildContext, Routes.SETTINGS);
        },
      ),
    ],
  );
}
