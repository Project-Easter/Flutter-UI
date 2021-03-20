import 'package:books_app/Models/book.dart';
import 'package:books_app/util/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Models/books.dart';
import 'package:books_app/Widgets/horizontal_list.dart';
import 'package:books_app/Widgets/filter_items.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    //Get Books from Sample Data Books Model
    // final ownedBooks = Provider.of<Books>(context).ownedBooks;
    final borrowedBooks = Provider.of<Books>(context).borrowedBooks;
    final lentBooks = Provider.of<Books>(context).lentBooks;
    // var savedBooks = Provider.of<Books>(context).savedBooks;
    //****
    //Listen to Stream From firebase. Get book List from firebase
    //Can setup another stream in Home page
    // List<Book> booksData = Provider.of<List<Book>>(context) ?? [];
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
    double height = 170.0;
    if (savedBooks != [] && ownedBooks != []) {}
    //print ratings
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

  //Appbar action:Filter
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
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                //Cannot see OK text on UI?
                'OK',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
          content: Container(
            width: 350,
            height: 200,
            //Filtering functions
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
