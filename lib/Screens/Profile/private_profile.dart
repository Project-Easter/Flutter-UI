import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Models/user.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Models/book.dart';

class PrivateProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<UserData>(context);
    final booksData = Provider.of<List<Book>>(context) ?? [];
    var ownedBooksLength;
    if (booksData.length == 0) {
      ownedBooksLength = 0;
    } else {
      ownedBooksLength = booksData.where((book) => book.isOwned).length;
    }
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

    return profileData == null || booksData == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Container(
                  //   padding: EdgeInsets.all(5),
                  //   child: CircleAvatar(
                  //     radius: 70,
                  //     backgroundImage: AssetImage('assets/placeholder.PNG'),
                  //   ),
                  // ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(profileData.photoURL),
                          ),
                        ),
                        Container(
                          child: Text(
                            // 'John Doe',
                            profileData.displayName,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 36, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "${profileData.city},${profileData.state}",
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
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
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(ownedBooksLength.toString(),
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400)),
                                Text('Owned Books')
                              ],
                            ),
                            Column(
                              children: [
                                Text("0",
                                    // borrowedBooksLength,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400)),
                                Text('Borrowed Books')
                              ],
                            ),
                            Column(
                              children: [
                                Text("0",
                                    // lentBooksLength,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400)),
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
                        button(context, blackButton, 'Library', Routes.LIBRARY),
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
