import 'package:books_app/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books_app/Widgets/horizontal_list.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Models/books.dart';
import 'package:books_app/Models/user.dart';

class ExploreNearby extends StatefulWidget {
  @override
  _ExploreNearbyState createState() => _ExploreNearbyState();
}

class _ExploreNearbyState extends State<ExploreNearby> {
  @override
  Widget build(BuildContext context) {
    final within3km = Provider.of<Books>(context).within3km;
    final within5km = Provider.of<Books>(context).within5km;
    final within10km = Provider.of<Books>(context).within10km;
    final within20km = Provider.of<Books>(context).within20km;
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      body: userData.latitude == 0.0 || userData.longitude == 0.0
          ? Center(
              child: Text('Please Update your Location'),
            )
          : Container(
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: getProportionateScreenHeight(50.0),
                    // ),
                    Text(
                      'Explore Nearby',
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    HorizontalList(150.0, within3km, 'Within 3 km'),
                    HorizontalList(150.0, within5km, 'Within 3-6 km'),
                    HorizontalList(150.0, within10km, 'Within 6-10 km'),
                    HorizontalList(150.0, within20km, 'Within 20 km'),
                    // FutureBuilder(
                    //     future: _determinePosition(),
                    //     builder: (ctx, snapshot) {
                    //       if (snapshot.hasData) {
                    //         Position position = snapshot.data;
                    //
                    //         return Text(
                    //             '${position.longitude}${position.longitude}');
                    //       } else if (snapshot.hasError) {
                    //         // show error widget
                    //         return Text(snapshot.error.toString());
                    //       } else {
                    //         // show loading widget
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       }
                    //     })
                  ],
                ),
              ),
            ),
    );
  }

  Widget headingText(String text) {
    return Container(
      height: getProportionateScreenHeight(36.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          color: Color(0xFF181926),
          fontSize: 20,
        ),
      ),
    );
  }
}
