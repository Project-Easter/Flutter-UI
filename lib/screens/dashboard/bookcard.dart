import 'package:books_app/providers/book.dart';
import 'package:books_app/screens/book_desciption.dart';
import 'package:books_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Book book = Provider.of<Book>(context);
    final String? _playStoreLink = book.infoLink;
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
                    BoxShadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 15)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(book.imageUrl!), fit: BoxFit.fill)),
            ),
            onTap: () async {
              (book.infoLink != null)
                  ? await _canLaunchUrl(_playStoreLink!)
                  : Navigator.of(context).push<dynamic>(
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => BookDescription(
                          bookFromList: book,
                        ),
                      ),
                    );
            },
          ),
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                width: getProportionateScreenWidth(100),
                child: Text(
                  book.title!,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                book.author!,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _canLaunchUrl(String url) async => canLaunch(url) != null
      ? await launch(url)
      : throw 'Could not open the play store link';
}
