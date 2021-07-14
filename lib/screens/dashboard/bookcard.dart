import 'package:books_app/Screens/book_desciption.dart';
import 'package:books_app/Utils/size_config.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String uid = AuthService().getUID;
    final DatabaseService _databaseService = DatabaseService(uid: uid);
    final Book book = Provider.of<Book>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: getProportionateScreenHeight(200),
              width: getProportionateScreenWidth(100),
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
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                book.title,
                textWidthBasis: TextWidthBasis.parent,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                // maxLines: 2,
                softWrap: true,
              ),
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
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.center,
              //   // crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text(
              //       book.author,
              //       style: GoogleFonts.poppins(
              //         color: Colors.black.withOpacity(0.5),
              //         fontWeight: FontWeight.w500,
              //         fontSize: 12,
              //       ),
              //       softWrap: true,
              //       maxLines: 2,
              //       overflow: TextOverflow.visible,
              //     ),
              //     // IconButton(
              //     //   onPressed: () {
              //     //     _databaseService.updateBookMark(book);
              //     //     book.changeBookMark();
              //     //   },
              //     //   icon: book.isBookMarked
              //     //       ? const Icon(Icons.bookmark)
              //     //       : const Icon(Icons.bookmark_outline_rounded),
              //     //   iconSize: 20,
              //     // ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
