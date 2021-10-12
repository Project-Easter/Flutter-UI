import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthErrorMessage extends StatelessWidget {
  final String errorMessage;

  const AuthErrorMessage({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
          softWrap: true,
          style: GoogleFonts.mali(color: Colors.red, fontSize: 15),
        ),
      );
    }

    return const SizedBox(width: 0.0, height: 0.0);
  }
}
