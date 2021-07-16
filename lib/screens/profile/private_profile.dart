import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/models/user.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrivateProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserData profileData = Provider.of<UserData>(context);
    final List<Book> booksData = Provider.of<List<Book>>(context) ?? <Book>[];
    int ownedBooksLength;
    if (booksData.isEmpty) {
      ownedBooksLength = 0;
    } else {
      ownedBooksLength =
          booksData.where((Book book) => book.isOwned == true).length;
    }
    List<Book> ownedBooks = [];
    booksData.forEach((Book book) {
      if (book.isOwned == true) {
        ownedBooks.add(book);
      }
    });
    final List<Book> savedBooks = [];
    booksData.forEach((Book book) {
      if (book.isBookMarked == true) {
        savedBooks.add(book);
      }
    });

    if (profileData == null || booksData == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(profileData.photoURL),
                    ),
                  ),
                  Text(
                    // 'John Doe',
                    profileData.displayName,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      profileData.city.isNotEmpty &&
                              profileData.state.isNotEmpty &&
                              profileData.countryName.isNotEmpty
                          ? '${profileData.city} , ${profileData.state}, ${profileData.countryName}'
                          : 'Update your location',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'User Stats',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(ownedBooksLength.toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            const Text('Owned Books')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('0',
                                // borrowedBooksLength,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            const Text('Borrowed Books')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('0',
                                // lentBooksLength,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            const Text('Lent Books')
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
                  children: <Widget>[
                    button(context, blackButton, 'Library', Routes.LIBRARY),
                    GestureDetector(
                      onTap: () {
                        AuthService().googleSignout();
                      },
                      child: button(
                          context, greenButton, 'Logout', Routes.INITIAL_PAGE),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
