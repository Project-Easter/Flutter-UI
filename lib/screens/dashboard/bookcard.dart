import 'package:flutter/material.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/screens/book_desciption.dart';
import 'package:google_fonts/google_fonts.dart';

class BookCard extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final uid = _authService.getUID;
    final DatabaseService _databaseService = DatabaseService(uid: uid);
    final book = Provider.of<Book>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: Container(
                height: 192,
                width: 140,
                decoration: new BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
                    borderRadius: BorderRadius.circular(10),
                    image: new DecorationImage(image: NetworkImage(book.imageUrl), fit: BoxFit.fill)),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookDescription(
                      bookFromList: book,
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: Text(
              book.title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.fade,
              maxLines: 2,
              softWrap: true,
            ),
          ),
          Text(
            book.author,
            style: GoogleFonts.poppins(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 100),
            child: IconButton(
              alignment: Alignment.topRight,
              onPressed: () {
                _databaseService.updateBookMark(book);
                book.changeBookMark();
              },
              icon: book.isBookMarked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_outline_rounded),
              iconSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
