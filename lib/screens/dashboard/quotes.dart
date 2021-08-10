import 'package:books_app/Utils/keys_storage.dart';
import 'package:books_app/constants/colors.dart';
import 'package:books_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return FutureBuilder(
      future: TokenStorage().loadAuthToken(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print('${snapshot.data} is the loadPrefs snappppyyy');
          return FutureBuilder<dynamic>(
              future: AuthService().getQuote(snapshot.data.toString()),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print(AuthService.googleAuthToken);
                  print(
                      'is the print for googleAuthTOken inside quote function');

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
                            style: GoogleFonts.lato(
                                color: blackButton, fontSize: 14),
                          ),
                        )
                      ]),
                    ),
                  );
                }
              });
        }
      },
    );
  }

  // Future<String> loadToken() async {

  //   FlutterSecureStorage storage = FlutterSecureStorage();
  //   quoteToken = await storage.read(key: 'global_token');
  //   print('$quoteToken is the quoteToken for FLutterStorage');
  //   return quoteToken;
  // }

  // FutureBuilder<String> token() {
  //   return FutureBuilder<String>(
  //       future: loadPrefs(),
  //       builder: (BuildContext tx, AsyncSnapshot snap) {
  //         if (snap.hasData) {
  //           return Text('${snap.data}');
  //         } else {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       });
  // }
}
