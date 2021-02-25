import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
MyAppBar() {
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
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () {},
      ),
    ],
  );
}
