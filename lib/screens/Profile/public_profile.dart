import 'package:books_app/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:books_app/util/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class PublicProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.settings,
                      size: 24.0,
                      color: Color(0xFF200E32),
                    ),
                    Text(
                      'My Profile',
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w300,
                          fontSize: 26),
                    ),
                    Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              flex: 15,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage('assets/placeholder.PNG'),
                        ),
                      ),
                      flex: 60,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          'John Doe',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      flex: 15,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'SAN FRANCISCO,CA',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      flex: 15,
                    ),
                  ],
                ),
              ),
              flex: 40,
            ),
            Divider(
              color: Colors.black54,
            ),
            Expanded(
              flex: 25,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'User Stats',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('10',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            Text('Owned Books')
                          ],
                        ),
                        Column(
                          children: [
                            Text('10',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            Text('Owned Books')
                          ],
                        ),
                        Column(
                          children: [
                            Text('10',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            Text('Owned Books')
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CupertinoStyleButton(
                    text: 'My Library',
                    onpress: () {},
                    color: Color(0xFF06070D),
                  ),
                  CupertinoStyleButton(
                    text: 'Edit Profile',
                    onpress: () {},
                    color: Color(0xFF0FB269),
                  ),
                  CupertinoStyleButton(
                    text: 'Change Preferences',
                    onpress: () {
                      Navigator.pushNamed(context, privateProfile);
                    },
                    color: Color(0xFF0FB269),
                  ),
                ],
              ),
              flex: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoStyleButton extends StatelessWidget {
  final String text;
  final Function onpress;
  final Color color;
  CupertinoStyleButton({this.text, this.onpress, this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(345.0),
      height: getProportionateScreenHeight(52.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: color,
        onPressed: onpress,
        child: Text(
          text,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
