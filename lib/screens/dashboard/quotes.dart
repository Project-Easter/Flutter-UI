import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/quotes.dart';

class Quotation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: <Widget>[
          Text(
            Quotes.getRandom().content,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.visible,
            style: GoogleFonts.lato(fontSize: 23, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              Quotes.getRandom().author,
              style: GoogleFonts.lato(fontSize: 14),
            ),
          )
        ]),
      ),
    );
  }
}
