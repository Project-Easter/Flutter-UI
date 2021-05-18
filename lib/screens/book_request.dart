import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookRequest extends StatefulWidget {
  @override
  _BookRequestState createState() => _BookRequestState();
}

class _BookRequestState extends State<BookRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellowAccent,
        child: Center(
          child: Text(
            "No Book Requests.",
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
