import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthErrorMessage extends StatelessWidget {
  final String errorMessage;

  AuthErrorMessage({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (this.errorMessage != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
        child: Text(
          this.errorMessage,
          textAlign: TextAlign.center,
          softWrap: true,
          style: GoogleFonts.muli(color: Colors.red, fontSize: 15),
        ),
      );
    }

    return Container(width: 0.0, height: 0.0);
  }
}
