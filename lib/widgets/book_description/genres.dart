import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 28,
            width: 140,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text('Action',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14)),
            ),
          ),
          Container(
            height: 28,
            width: 140,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Fantasy',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
