import 'package:books_app/providers/book.dart';
import 'package:books_app/screens/dashboard/book_list.dart';
import 'package:books_app/utils/size_config.dart';
import 'package:books_app/widgets/empty_page.dart';
import 'package:books_app/widgets/filter_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final List<Book> booksData = Provider.of<List<Book>>(context) ?? <Book>[];
    final List<Book> ownedBooks = <Book>[];
    final List<Book> lentBooks = <Book>[];
    final List<Book> borrowedBooks = <Book>[];

    for (final Book book in booksData) {
      if (book.isOwned == true) {
        ownedBooks.add(book);
      }
    }
    final List<Book> savedBooks = <Book>[];
    for (final Book book in booksData) {
      if (book.isBookMarked == true) {
        savedBooks.add(book);
      }
    }

    // ignore: always_specify_types
    if (savedBooks.isEmpty && ownedBooks.isEmpty) {
      return const EmptyPageWidget(
        headline: 'This page will contain all the your book data ',
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (ownedBooks.isNotEmpty)
              BookList('Owned Books', ownedBooks)
            else
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: EmptyPageWidget(headline: 'No books owned'),
              ),
            if (savedBooks.isNotEmpty)
              BookList('Saved Books', savedBooks)
            else
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: EmptyPageWidget(headline: 'No saved books right now'),
              ),

            if (lentBooks.isNotEmpty)
              BookList('Lent Books', lentBooks)
            else
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: EmptyPageWidget(headline: 'No books lent'),
              ),

            if (borrowedBooks.isNotEmpty)
              BookList('Borrowed', borrowedBooks)
            else
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: EmptyPageWidget(headline: 'No books borrowed'),
              ),

            // if (ownedBooks != <Book>[]) BookList('Owned Books', ownedBooks)

            // HorizontalList(170, lentBooks, 'Lent Books'),
            // HorizontalList(170, borrowedBooks, 'Borrowed Books'),
            // HorizontalList(170, savedBooks, 'Saved Books'),
          ],
        ),
      );
    }
  }

  Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // ignore: sized_box_for_whitespace
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

  // void openDialog() {
  //   showDialog<Text>(
  //     context: context,
  //     builder: (BuildContext ctx) {
  //       return AlertDialog(
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text(
  //               'CANCEL',
  //               style: GoogleFonts.poppins(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w300),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text(
  //               'OK',
  //               style: GoogleFonts.poppins(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w300),
  //             ),
  //           )
  //         ],
  //         // ignore: sized_box_for_whitespace
  //         content: Container(
  //           width: 350,
  //           height: 200,
  //           child: FilterItems(),
  //         ),
  //       );
  //     },
  //   );
  // }
}
