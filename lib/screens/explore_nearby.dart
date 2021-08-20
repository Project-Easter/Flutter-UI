import 'package:books_app/widgets/empty_page.dart';
import 'package:flutter/material.dart';

class ExploreNearby extends StatefulWidget {
  @override
  _ExploreNearbyState createState() => _ExploreNearbyState();
}

class _ExploreNearbyState extends State<ExploreNearby> {
  // LocationRange distance;
  @override
  Widget build(BuildContext context) {
    // final List<Book> within3km = Provider.of<Books>(context).within3km;
    // final List<Book> within5km = Provider.of<Books>(context).within5km;
    // final List<Book> within10km = Provider.of<Books>(context).within10km;
    // final List<Book> within20km = Provider.of<Books>(context).within20km;
    // final UserData userData = Provider.of<UserData>(context);
    return const Scaffold(
      body: EmptyPageWidget(
          headline: 'No books available right now. Keep your location updated'),
    );
  }
}
