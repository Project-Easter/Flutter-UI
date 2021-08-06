import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyPageWidget extends StatelessWidget {
  final String headline;

  const EmptyPageWidget({Key key, @required this.headline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image.asset('assets/Placeholder.png'),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            // 'This page will contain all the your book data ',
            headline,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      )
    ]);
  }
}
