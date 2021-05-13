import 'package:books_app/Models/book.dart';
import 'package:books_app/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Widgets/horizontal_list.dart';
import 'package:books_app/Widgets/filter_items.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final booksData = Provider.of<List<Book>>(context) ?? [];
    List<Book> ownedBooks = [];
    booksData.forEach((book) {
      if (book.isOwned == true) {
        ownedBooks.add(book);
      }
    });
    List<Book> savedBooks = [];
    booksData.forEach((book) {
      if (book.isBookMarked) {
        savedBooks.add(book);
      }
    });

    if (savedBooks != [] && ownedBooks != []) {}

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorizontalList(170, ownedBooks, 'Owned Books'),
              // HorizontalList(170, lentBooks, 'Lent Books'),
              // HorizontalList(170, borrowedBooks, 'Borrowed Books'),
              HorizontalList(170, savedBooks, 'Saved Books'),
            ],
          ),
        ),
      ),
    );
  }

  void openDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CANCEL',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
              ),
            )
          ],
          content: Container(
            width: 350,
            height: 200,
            child: FilterItems(),
          ),
        );
      },
    );
  }

  Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: getProportionateScreenHeight(36.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
