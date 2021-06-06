import 'package:books_app/Screens/book_desciption.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final String uid = _authService.getUID as String;
    // final DatabaseService _databaseService = DatabaseService(uid: uid);
    final Book book = Provider.of<Book>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: Container(
              height: 192,
              width: 135,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    const BoxShadow(color: Colors.grey, blurRadius: 15)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(book.imageUrl), fit: BoxFit.fill)),
            ),
            onTap: () {
              Navigator.of(context).push<dynamic>(
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => BookDescription(
                    bookFromList: book,
                  ),
                ),
              );
            },
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              book.title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 2,
              softWrap: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  book.author,
                  style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
                // IconButton(
                //   onPressed: () {
                //     _databaseService.updateBookMark(book);
                //     book.changeBookMark();
                //   },
                //   icon: book.isBookMarked
                //       ? Icon(Icons.bookmark)
                //       : Icon(Icons.bookmark_outline_rounded),
                //   iconSize: 20,
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
