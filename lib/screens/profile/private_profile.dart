import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final List<Book> ownedBooks = <Book>[];
    booksData.forEach((Book book) {
      if (book.isOwned == true) {
        ownedBooks.add(book);
      }
    });
    final List<Book> savedBooks = <Book>[];
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
                      (profileData.city != null || profileData.state != null)
                          ? '${profileData.city} , ${profileData.state}'
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
                    button(
                        context, blackButton, 'Add you Book', Routes.ADD_BOOK),
                    button(context, blackButton, 'Settings', Routes.SETTINGS),
                    // GestureDetector(
                    //   onTap: () {
                    //     AuthService().googleSignout();
                    //   },
                    //   child: button(
                    //       context, greenButton, 'Logout', Routes.INITIAL_PAGE),
                    // )
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
