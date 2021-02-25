import 'package:books_app/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/search_box.dart';
import 'widgets/horizontal_list.dart';
import 'widgets/filter_items.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Models/books.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final ownedBooks = Provider.of<Books>(context).ownedBooks;
    final borrowedBooks = Provider.of<Books>(context).borrowedBooks;
    final lentBooks = Provider.of<Books>(context).lentBooks;
    final savedBooks = Provider.of<Books>(context).savedBooks;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: getProportionateScreenHeight(330.0) * 0.8,
              floating: false,
              //Try pinned (false/true) and see how it looks
              // pinned: false,
              pinned: true,
              actions: <Widget>[
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
                //TODO:2.Remove this Icon and adjust the routes
                IconButton(
                    icon: Icon(Icons.settings),
                    color: Color(0xFF666666),
                    onPressed: () {
                      Navigator.pushNamed(context, exploreNearby);
                    }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'My Library',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w400),
                ),
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/search_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      SearchBox(),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: Container(
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //This code is as the design
                // SizedBox(
                //   height: getProportionateScreenHeight(50.0),
                // ),
                // Container(
                //   width: getProportionateScreenWidth(330.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'My Library',
                //         style: GoogleFonts.poppins(
                //             color: Colors.black,
                //             fontSize: 26,
                //             fontWeight: FontWeight.w400),
                //       ),
                //       IconButton(
                //           icon: Icon(Icons.settings),
                //           color: Color(0xFF666666),
                //           onPressed: () {
                //             Navigator.pushNamed(context, exploreNearby);
                //           }),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: getProportionateScreenHeight(25),
                // ),
                // // SearchBox(openDialog),
                // SizedBox(
                //   height: getProportionateScreenHeight(15.0),
                // ),
                headingText('Owned Books'),
                HorizontalList(170, ownedBooks),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                headingText('Lent Books'),
                HorizontalList(170, lentBooks),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                headingText('Borrowed Books'),
                HorizontalList(170, borrowedBooks),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                headingText('Saved Books'),
                HorizontalList(170, savedBooks),
              ],
            ),
          ),
        ),
      ),
      //TODO:1.Add bottom NavigationBar and adjust routes
    );
  }

  //Appbar action:Filter
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
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
          content: Container(
            width: 350,
            height: 200,
            //Filtering functions
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
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }
}
