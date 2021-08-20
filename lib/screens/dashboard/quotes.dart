import 'package:books_app/Utils/backend/quote_request.dart';
import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/Utils/keys_storage.dart';
import 'package:books_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class Quote {
  final String quote;
  final String author;

  Quote({
    this.quote,
    this.author,
  });
}

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  String quoteToken;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quote>(
        future: getQuote(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
          

            print('Quote snapshot isss ${snapshot.data}');

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(children: <Widget>[
                  Text(
                    '${snapshot.data.quote}',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        color: blackButton,
                        fontSize: 23,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${snapshot.data.author}',
                      style: GoogleFonts.lato(color: blackButton, fontSize: 14),
                    ),
                  )
                ]),
              ),
            );
          }
        });
  }

  Future<Quote> getQuote() async {
   
    final Response response = await QuoteRequest.getQuoteData(TokenStorage.authToken);
    final dynamic result = await getBodyFromResponse(response);
       if (response.statusCode == 200) {
        print('Result is $result');
      }
    // try {
    //   print('Quote body result inside getQuote is $result');
    //   if (response.statusCode == 200) {
    //     print('Result is $result');
    //   }
    // } catch (e) {
    //   print(e.toString()+'is the error inside getQuote function');
      
    // }
    return Quote(
      author: result['author'].toString(),
      quote: result['text'].toString(),
    );
  }
}
