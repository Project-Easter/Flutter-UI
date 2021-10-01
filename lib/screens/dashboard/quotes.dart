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
            Quotes.getFirst().content,
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
              Quotes.getFirst().author,
              style: GoogleFonts.lato(fontSize: 14),
            ),
          )
        ]),
      ),
    );
  }
}
// class Quote {
//   final String quote;
//   final String author;

//   Quote({
//     this.quote,
//     this.author,
//   });
// }

// class Quotation extends StatefulWidget {
//   @override
//   _QuotesState createState() => _QuotesState();
// }

// class _QuotesState extends State<Quotation> {
//   String quoteToken;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(children: <Widget>[
//           Text(
//             Quotation.author,
//             softWrap: true,
//             maxLines: 3,
//             overflow: TextOverflow.visible,
//             style: GoogleFonts.lato(fontSize: 23, fontStyle: FontStyle.italic),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Text(
//               '${snapshot.data.author}',
//               style: GoogleFonts.lato(fontSize: 14),
//             ),
//           )
//         ]),
//       ),
//     );
//   }

//   // Future<Quote> getQuote() async {

//   //   final Response response = await QuoteRequest.getQuoteData(TokenStorage.authToken);
//   //   final dynamic result = await getBodyFromResponse(response);
//   //      if (response.statusCode == 200) {
//   //       print('Result is $result');
//   //     }
//   //   return Quote(
//   //     author: result['author'].toString(),
//   //     quote: result['text'].toString(),
//   //   );
//   // }
// }
