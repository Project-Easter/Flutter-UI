import 'package:books_app/providers/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnerInfo extends StatefulWidget {
  String? userid;
  OwnerInfo({this.userid});
  @override
  _OwnerInfoState createState() => _OwnerInfoState();
}

class _OwnerInfoState extends State<OwnerInfo> {
  //UserData userdata;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: StreamBuilder<UserData>(
          stream: DatabaseService().getUserData(widget.userid),
          builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final UserData? owner = snapshot.data;
              return Column(
                children: <Widget>[
                  Text(
                    '${owner!.displayName}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${owner.streetAddress}, ${owner.city}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    owner.email ?? 'Email not found.',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
