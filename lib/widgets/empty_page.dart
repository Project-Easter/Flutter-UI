import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyPageWidget extends StatelessWidget {
  final String headline;

  const EmptyPageWidget({Key key, @required this.headline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.network(
          'https://firebasestorage.googleapis.com/v0/b/dashatar-dev.appspot.com/o/dashatars%2FRGFzaGF0YXJfQm9udXNfU2V0c19Cb251c19F.png?alt=media'),
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
