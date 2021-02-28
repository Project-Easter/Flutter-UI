import 'package:books_app/Constants/routes.dart';
import 'package:books_app/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books_app/Widgets/horizontal_list.dart';
import 'package:books_app/Widgets/filter_items.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Nearby',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.format_align_left,
                      color: Colors.black54,
                    ),
                    tooltip: 'Filter Items',
                    onPressed: () {
                      openDialog();
                    },
                  ),
                  //TODO:5.Remove Icon and Adjust routes
                  IconButton(
                      icon: Icon(Icons.settings),
                      color: Color(0xFF666666),
                      onPressed: () {
                        Navigator.pushNamed(context, publicProfile);
                      }),
                ],
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

  void openDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CANCEL',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
          content: Container(
            width: 300,
            height: 200,
            child: FilterItems(),
          ),
        );
      },
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
