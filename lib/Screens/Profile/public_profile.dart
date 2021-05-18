import 'package:books_app/constants/Routes.dart';
import 'package:books_app/models/books.dart';
import 'package:books_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PublicProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ownedBooksLength = Provider.of<Books>(context).ownedBooks.length.toString();
    final borrowedBooksLength = Provider.of<Books>(context).borrowedBooks.length.toString();
    final lentBooksLength = Provider.of<Books>(context).lentBooks.length.toString();
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
                      style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w300, fontSize: 26),
                    ),
                    Text(
                      'Logout',
                      style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 13),
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
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 36, fontWeight: FontWeight.w400),
                        ),
                      ),
                      flex: 15,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'SAN FRANCISCO,CA',
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
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
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(ownedBooksLength, style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400)),
                            Text('Owned Books')
                          ],
                        ),
                        Column(
                          children: [
                            Text(lentBooksLength, style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400)),
                            Text('Lent Books')
                          ],
                        ),
                        Column(
                          children: [
                            Text(borrowedBooksLength, style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400)),
                            Text('Borrowed Books')
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
                    name: 'My Library',
                    myFunction: () {},
                    color: Color(0xFF06070D),
                  ),
                  CupertinoStyleButton(
                    name: 'Edit Profile',
                    myFunction: () {},
                    color: Color(0xFF0FB269),
                  ),
                  CupertinoStyleButton(
                    name: 'Change Preferences',
                    myFunction: () {
                      Navigator.pushNamed(context, Routes.PRIVATE_PROFILE);
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
