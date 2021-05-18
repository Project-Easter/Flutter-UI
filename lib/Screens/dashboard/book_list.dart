import 'package:books_app/Screens/dashboard/bookcard.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookList extends StatelessWidget {
  final String title;
  final List<Book> bookList;
  BookList(this.title, this.bookList);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: Text(title, style: GoogleFonts.poppins(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600)),
        ),
        Container(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bookList.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(value: bookList[index], child: BookCard()),
          ),
        ),
      ],
    );
  }
}
