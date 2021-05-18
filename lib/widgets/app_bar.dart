import 'package:books_app/constants/routes.dart';
import 'package:books_app/widgets/filter_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
MyAppBar(BuildContext buildContext) {
  void openDialog() {
    showDialog(
      context: buildContext,
      builder: (ctx) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(buildContext);
              },
              child: Text(
                'CANCEL',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(buildContext);
              },
              child: Text(
                'Ok',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
          ],
          content: Container(
            width: 300,
            height: 200,
            child: FilterItems(),
          ),
        );
      },
    );
  }

  return AppBar(
    shadowColor: Colors.black,
    bottomOpacity: 0.5,
    titleSpacing: 5,
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: Icon(
      Icons.book_outlined,
      color: Colors.black,
    ),
    title: Text(
      'Explr',
      style: GoogleFonts.muli(color: Colors.black),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.search_rounded,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.filter_list_alt,
          color: Colors.black,
          size: 20,
        ),
        tooltip: 'Filter Items',
        onPressed: () {
          openDialog();
        },
      ),
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () {
          Navigator.pushNamed(buildContext, Routes.SETTINGS);
        },
      ),
    ],
  );
}
