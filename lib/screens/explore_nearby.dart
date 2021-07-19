import 'package:books_app/models/book.dart';
import 'package:books_app/models/books.dart';
import 'package:books_app/models/user.dart';
import 'package:books_app/screens/dashboard/book_list.dart';
import 'package:books_app/screens/user_preferences.dart';
import 'package:books_app/widgets/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExploreNearby extends StatefulWidget {
  @override
  _ExploreNearbyState createState() => _ExploreNearbyState();
}

class _ExploreNearbyState extends State<ExploreNearby> {
  LocationRange distance;
  @override
  Widget build(BuildContext context) {
    // final List<Book> within3km = Provider.of<Books>(context).within3km;
    // final List<Book> within5km = Provider.of<Books>(context).within5km;
    final List<Book> within10km = Provider.of<Books>(context).within10km;
    // final List<Book> within20km = Provider.of<Books>(context).within20km;
    final UserData userData = Provider.of<UserData>(context);
    return Scaffold(
      body: userData.latitude == 0.0 || userData.longitude == 0.0
          ? const EmptyPageWidget(
              headline:
                  'No books available right now. Keep your location updated')
          : Container(
              width: double.infinity,
              color: Colors.white,
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Explore Nearby',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w400),
                    ),
                    BookList('Within $distance', within10km),
                  ],
                ),
              ),
            ),
    );
  }
}
