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

    final ownedBooks = Provider.of<Books>(context).ownedBooks;
    final borrowedBooks = Provider.of<Books>(context).borrowedBooks;
    final lentBooks = Provider.of<Books>(context).lentBooks;
    final savedBooks = Provider.of<Books>(context).savedBooks;
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(50.0),
              ),
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
              SizedBox(
                height: getProportionateScreenHeight(15.0),
              ),
              headingText('Within 3 km'),
              HorizontalList(150, ownedBooks),
              SizedBox(
                height: getProportionateScreenHeight(15.0),
              ),
              headingText('Within 3-6 km'),
              HorizontalList(150, borrowedBooks),
              SizedBox(
                height: getProportionateScreenHeight(15.0),
              ),
              headingText('Within 6-10 km'),
              HorizontalList(150, lentBooks),
              SizedBox(
                height: getProportionateScreenHeight(15.0),
              ),
              headingText('Within 20 km'),
              HorizontalList(150, savedBooks),
            ],
          ),
        ),
      ),
      //TODO:6.Add BottomNav Icon and Adjust routes
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
