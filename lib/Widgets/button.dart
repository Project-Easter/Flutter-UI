import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget button(
    BuildContext context, Color buttonColor, String name, String pageRoute) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: AspectRatio(
      aspectRatio: 343 / 52,
      child: Container(
        child: RaisedButton(
          color: buttonColor,
          child: new Text(
            name,
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          onPressed: () async {
            Navigator.pushNamed(context, pageRoute);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    ),
  );
}
