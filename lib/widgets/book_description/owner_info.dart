import 'package:books_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
      child: Consumer<UserModel>(
          builder: (BuildContext context, UserModel owner, _) {
        return Column(
          children: <Widget>[
            Text(
              '${owner.firstName} ${owner.lastName}',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w400),
            ),
            // Text(
            //   'SAN FRANSISCO, CA',
            //   style: GoogleFonts.poppins(
            //       color: Colors.black,
            //       fontSize: 14,
            //       fontWeight: FontWeight.w500),
            // ),
            Text(
              owner.email,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
          ],
        );
      }),
    );
  }
}
