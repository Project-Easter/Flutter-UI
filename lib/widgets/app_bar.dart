import 'package:books_app/constants/routes.dart';
import 'package:books_app/widgets/filter_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
AppBar MyAppBar(BuildContext buildContext) {
  void openDialog() {
    showDialog<Text>(
      context: buildContext,
      builder: (BuildContext ctx) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(buildContext);
              },
              child: Text(
                'CANCEL',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(buildContext);
              },
              child: Text(
                'Ok',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
          content: SizedBox(
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
    leading: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Image.asset('assets/images/ExplrLogo(150x150).png'),
    ),
    title: const Text(
      'Explr',
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search_rounded,
          size: 20,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(
          Icons.filter_list_alt,
          size: 20,
        ),
        tooltip: 'Filter Items',
        onPressed: () {
          openDialog();
        },
      ),
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
