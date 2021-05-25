import 'package:flutter/material.dart';
import 'package:books_app/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Models/book.dart';
import 'package:books_app/Screens/book_desciption.dart';
import 'package:google_fonts/google_fonts.dart';

class BookCard extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final String uid = _authService.getUID as String;
    // final DatabaseService _databaseService = DatabaseService(uid: uid);
    final book = Provider.of<Book>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: Container(
              height: 192,
              width: 135,
              decoration: new BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
                  borderRadius: BorderRadius.circular(10),
                  image: new DecorationImage(
                      image: NetworkImage(book.imageUrl), fit: BoxFit.fill)),
            ),
            onTap: () {
              Navigator.of(context).push<dynamic>(
                MaterialPageRoute<dynamic>(
                  builder: (context) => BookDescription(
                    bookFromList: book,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 135,
          child: Column(
            children: [
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
                children: [
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
        ),
      ],
    );
  }
}
