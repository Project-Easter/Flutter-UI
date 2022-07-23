import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/books.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:books_app/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard/book_list.dart';

class ExploreNearby extends StatelessWidget {
//   @override
//   _ExploreNearbyState createState() => _ExploreNearbyState();
// }

// class _ExploreNearbyState extends State<ExploreNearby> {

  // LocationRange distance;

  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context);
    final List<Book> within3km = Provider.of<Books>(context).within3km;
    final List<Book> within5km = Provider.of<Books>(context).within5km;
    final List<Book> within10km = Provider.of<Books>(context).within10km;
    final List<Book> within20km = Provider.of<Books>(context).within20km;
    final List<Book> morethan20km = Provider.of<Books>(context).morethan20km;

    final DatabaseService _databaseService =
        DatabaseService(uid: userData.uid.toString());
    final LocationHelper _locationHelper = LocationHelper();

    return Scaffold(
      body: FutureBuilder<List<UserData>>(
          future: _databaseService.allUsers,
          builder: (BuildContext ctx, AsyncSnapshot<List<UserData>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final List<UserData>? users = snapshot.data;
              print('users: ${users?.length}');

              for (UserData element in users!) {
                // first of we are calculating distances
                final num dist = _locationHelper.calculateDistance(
                    lat1: userData.latitude,
                    lat2: element.latitude,
                    lon1: userData.longitude,
                    lon2: element.longitude);

                // print('Distance: $dist');
                if (element.uid != null) if (dist <= 3) {
                  // print('dist <= 3: ' + element.uid.toString());
                  _databaseService
                      .getBooks(uid: element.uid)
                      .then((List<Book> value) {
                    within3km.addAll(value);
                    within3km.toSet();
                  });
                } else if (dist > 3 && dist <= 5) {
                  // print('dist > 3 && dist <= 5: ' + element.uid.toString());
                  _databaseService
                      .getBooks(uid: element.uid)
                      .then((List<Book> value) {
                    within5km.addAll(value);
                  });
                } else if (dist > 5 && dist <= 10) {
                  // print('dist > 5 && dist <= 10: ' + element.uid.toString());
                  _databaseService
                      .getBooks(uid: element.uid)
                      .then((List<Book> value) {
                    within10km.addAll(value);
                  });
                } else if (dist > 10 && dist <= 20) {
                  // print('dist > 10 && dist <= 20: ' + element.uid.toString());
                  _databaseService
                      .getBooks(uid: element.uid)
                      .then((List<Book> value) {
                    within20km.addAll(value);
                  });
                } else if (dist > 20) {
                  print('dist > 20: ' + element.uid.toString());
                  _databaseService
                      .getBooks(uid: element.uid)
                      .then((List<Book> value) {
                    morethan20km.addAll(value);
                  });
                }
              }

              return Scaffold(
                  body: SingleChildScrollView(
                      child: Column(
                children: <Widget>[
                  //within 5 km
                  BookList(
                    'Within 3 km',
                    within3km.toSet().toList(),
                    subtitle: '(${within3km.length} books nearby)',
                  ),

                  //within 5 km
                  BookList(
                    'Within 5 km',
                    within5km.toSet().toList(),
                    subtitle: '(${within5km.length} books nearby)',
                  ),

                  //within 10 km
                  BookList(
                    'Within 10 km',
                    within10km.toSet().toList(),
                    subtitle: '(${within10km.length} books nearby)',
                  ),

                  //within 20 km
                  BookList(
                    'Within 20 km',
                    within20km.toSet().toList(),
                    subtitle: '(${within20km.length} books nearby)',
                  ),

                  //more 20 km
                  BookList(
                    'More than 20 km',
                    morethan20km.toSet().toList(),
                    subtitle: '(${morethan20km.length} books nearby)',
                  ),
                ],
              )));
            }
          }),
    );
  }
}
