import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Models/user.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../Models/books.dart';
import '../../Services/auth.dart';
import '../../Models/book.dart';

class PrivateProfile extends StatelessWidget {
  //Init AuthService
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    // final ownedBooksLength =
    //     Provider.of<Books>(context).ownedBooks.length.toString();
    final borrowedBooksLength =
        Provider.of<Books>(context).borrowedBooks.length.toString();
    final lentBooksLength =
        Provider.of<Books>(context).lentBooks.length.toString();
    //TEST USER Get Data
    final profileData = Provider.of<UserData>(context);
    //TODO:Available user data. Implement live data from firebase and implement Edit Screen
    //User profile data will be null at first. Check
    // print(profileData.phoneNumber);
    // print(profileData.email);
    // print(profileData.displayName);
    // print(profileData.city);
    // print(profileData.state);
    //Redundant code fix this. Just need to get the length of owned Books,borrowed,saved Books

    //TODO:Fix current books length showing wrong. =>

    final booksData = Provider.of<List<Book>>(context) ?? [];
    var ownedBooksLength = booksData.length;
    // List<Book> ownedBooks = [];
    // booksData.forEach((book) {
    //   if (book.isOwned == true) {
    //     ownedBooks.add(book);
    //   }
    // });
    // List<Book> savedBooks = [];
    // booksData.forEach((book) {
    //   if (book.isBookMarked) {
    //     savedBooks.add(book);
    //   }
    // });

    return profileData == null
        ? CircularProgressIndicator()
        : Scaffold(
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'My Profile',
                            style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: 26),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              await _authService.signOutNormal();
                              print("Logged Out");
                              //No need of this.We using current user status
                              Navigator.pushReplacementNamed(
                                  context, startupPage);
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          padding: EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                AssetImage('assets/placeholder.PNG'),
                          ),
                        ),
                        Container(
                          child: Text(
                            // 'John Doe',
                            profileData.displayName,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "${profileData.city},${profileData.state}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
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
                                Text(ownedBooksLength.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400)),
                                Text('Owned Books')
                              ],
                            ),
                            Column(
                              children: [
                                Text("0",
                                    // borrowedBooksLength,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400)),
                                Text('Borrowed Books')
                              ],
                            ),
                            Column(
                              children: [
                                Text("0",
                                    // lentBooksLength,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400)),
                                Text('Lent Books')
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        button(context, blackButton, 'Library', libraryPage),
                        button(context, greenButton, 'Send Message', ''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
