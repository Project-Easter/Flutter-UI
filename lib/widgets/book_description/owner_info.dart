import 'package:books_app/providers/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnerInfo extends StatefulWidget {
  final String? userid;
  const OwnerInfo({this.userid});
  @override
  _OwnerInfoState createState() => _OwnerInfoState();
}

class _OwnerInfoState extends State<OwnerInfo> {
  //UserData userdata;
  @override
  Widget build(BuildContext context) {
    return widget.userid != null
        ? Padding(
            padding: const EdgeInsets.all(15),
            child: StreamBuilder<UserData>(
                stream: DatabaseService().getUserData(widget.userid),
                builder:
                    (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final UserData owner = snapshot.data!;
                      return Column(
                        children: <Widget>[
                          Text(
                            owner.displayName ?? 'No Name Available',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${owner.streetAddress ?? 'None'}, ${owner.city ?? 'No city'}',
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
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting)
                      return const Center(child: CircularProgressIndicator());
                    else if (snapshot.connectionState == ConnectionState.none)
                      return const Text('No Snap Data');
                  }

                  return Column(
                    children: <Widget>[
                      Text(
                        'No Owner',
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'You can purchase this book from Play Store',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      // Text(
                      //   owner.email ?? 'Email not found.',
                      //   style: GoogleFonts.poppins(
                      //       color: Colors.black,
                      //       fontSize: 17,
                      //       fontWeight: FontWeight.w400),
                      // ),
                    ],
                  );
                }),
          )
        : Column(
            children: <Widget>[
              Text(
                'No Owner',
                maxLines: 1,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'You can purchase this book from Play Store',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              // Text(
              //   owner.email ?? 'Email not found.',
              //   style: GoogleFonts.poppins(
              //       color: Colors.black,
              //       fontSize: 17,
              //       fontWeight: FontWeight.w400),
              // ),
            ],
          );
  }
}
