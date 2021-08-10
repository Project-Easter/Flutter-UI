import 'package:books_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnerInfo extends StatefulWidget {
  @override
  _OwnerInfoState createState() => _OwnerInfoState();
}

class _OwnerInfoState extends State<OwnerInfo> {
  UserData ownerData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Text(
            'Jane Doe',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 36, fontWeight: FontWeight.w400),
          ),
          Text(
            'SAN FRANSISCO, CA',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            'jane@example.com',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
