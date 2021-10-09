import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/books.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:books_app/utils/location_helper.dart';
import 'package:books_app/widgets/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard/book_list.dart';

class ExploreNearby extends StatefulWidget {
  @override
  _ExploreNearbyState createState() => _ExploreNearbyState();
}

class _ExploreNearbyState extends State<ExploreNearby> {
  // LocationRange distance;
  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context);
    final List<Book> within3km = Provider.of<Books>(context).within3km;
    final List<Book> within5km = Provider.of<Books>(context).within5km;
    final List<Book> within10km = Provider.of<Books>(context).within10km;
    final List<Book> within20km = Provider.of<Books>(context).within20km;
    final List<Book> morethan20km = Provider.of<Books>(context).within20km;

    final DatabaseService _databaseService =
        DatabaseService(uid: userData.uid.toString());
    final LocationHelper _locationHelper = LocationHelper();

    return StreamBuilder<List<UserData>>(
        stream: _databaseService.allUsers,
        builder: (BuildContext ctx, AsyncSnapshot<List<UserData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // data parsing
            final List<UserData> users = snapshot.data;
            print(users.length);

            for (UserData element in users) {
              final num dist = _locationHelper.calculateDistance(
                  lat1: userData.latitude,
                  lat2: element.latitude,
                  lon1: userData.longitude,
                  lon2: element.longitude);

              print(dist);
              if (dist <= 3) {
                _databaseService
                    .getBooks(uid: element.uid)
                    .then((List<Book> value) {
                  within3km.addAll(value);
                });
              } else if (dist > 3 && dist <= 5) {
                _databaseService
                    .getBooks(uid: element.uid)
                    .then((List<Book> value) {
                  within5km.addAll(value);
                });
              } else if (dist > 5 && dist <= 10) {
                _databaseService
                    .getBooks(uid: element.uid)
                    .then((List<Book> value) {
                  within10km.addAll(value);
                });
              } else if (dist > 10 && dist <= 20) {
                _databaseService
                    .getBooks(uid: element.uid)
                    .then((List<Book> value) {
                  within20km.addAll(value);
                });
              } else {
                print('else ' + element.uid.toString());
                _databaseService
                    .getBooks(uid: element.uid)
                    .then((List<Book> value) {
                  print(value.length);
                  morethan20km.addAll(value);
                });
              }
            }

            return Scaffold(
                body: SingleChildScrollView(
              child: (within3km.isNotEmpty ||
                      within5km.isNotEmpty ||
                      within10km.isNotEmpty ||
                      within20km.isNotEmpty ||
                      morethan20km.isNotEmpty)
                  ? Column(
                      children: <Widget>[
                        //within 5 km
                        BookList('Within 3 km', within3km),

                        //within 5 km
                        BookList('Within 5 km', within5km),

                        //within 10 km
                        BookList('Within 10 km', within10km),

                        //within 20 km
                        BookList('Within 20 km', within20km),

                        //more 20 km
                        BookList('More than 20 km', morethan20km),
                      ],
                    )
                  : const EmptyPageWidget(
                      headline:
                          'No books available right now. Keep your location updated',
                    ),
            ));
          }
        });
  }
}
