import 'package:books_app/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books_app/Widgets/horizontal_list.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Models/books.dart';

class ExploreNearby extends StatefulWidget {
  @override
  _ExploreNearbyState createState() => _ExploreNearbyState();
}

class _ExploreNearbyState extends State<ExploreNearby> {
  @override
  Widget build(BuildContext context) {
    //This is dummy data and is used just for demonstration
    //Will change with other users data and geolocation
    final within3km = Provider.of<Books>(context).within3km;
    final within5km = Provider.of<Books>(context).within5km;
    final within10km = Provider.of<Books>(context).within10km;
    final within20km = Provider.of<Books>(context).within20km;
    return Scaffold(
      body: Container(
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
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              HorizontalList(150.0, within3km, 'Within 3 km'),
              HorizontalList(150.0, within5km, 'Within 3-6 km'),
              HorizontalList(150.0, within10km, 'Within 6-10 km'),
              HorizontalList(150.0, within20km, 'Within 20 km'),
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
