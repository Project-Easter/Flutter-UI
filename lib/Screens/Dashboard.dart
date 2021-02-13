import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Screens/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _search = new TextEditingController();
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 10,
          elevation: 0.0,
          backgroundColor: Colors.white10,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.navigate_before_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 28,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              quotes(),
              userChoice(),
              booksTile('Discover New'),
              booksTile('Recommended for you'),

              // SizedBox(
              //   height: 10,
              // ),
              // RaisedButton(
              //   child: Text('Signout'),
              //   onPressed: () {
              //     FirebaseAuth.instance.signOut();
              //     Navigator.of(context).pop();
              //   },
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // RaisedButton(
              //   child: Text('Signout from Facebook'),
              //   onPressed: () {
              //     AuthService().facebookSignout();
              //     Navigator.of(context).pop();
              //   },
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // RaisedButton(
              //   child: Text('Signout from Google'),
              //   onPressed: () {
              //     AuthService().googleSignout();
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
        ));
  }

  booksTile(String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
        ),
        Container(
          height: 320,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              book(
                  'https://images.unsplash.com/photo-1592903189708-add4d2987b1d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=508&q=80',
                  'The Golem and the Jinni',
                  'Helence Wecker'),
              book(
                  'https://images.unsplash.com/photo-1607948937289-5ca19c59e70f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bm92ZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                  'Economics:The User Guide',
                  'Ha-Joon Chang'),
              book(
                  'https://images.unsplash.com/photo-1573488721809-e0f256ad3ad8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fG5vdmVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                  'Endurance',
                  'Alfred Lansing'),
            ],
          ),
        )
      ],
    );
  }

  book(String imageLink, String bookName, String authorName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 192,
              width: 140,
              decoration: new BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
                  borderRadius: BorderRadius.circular(10),
                  image: new DecorationImage(
                      image: NetworkImage(imageLink), fit: BoxFit.fill)),
            ),
          ),
          Text(
            bookName,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            authorName,
            style: GoogleFonts.poppins(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.star,
                size: 15,
              ),
              Icon(
                Icons.star,
                size: 15,
              ),
              Icon(
                Icons.star,
                size: 15,
              ),
              Icon(
                Icons.star,
                size: 15,
              ),
              Icon(
                Icons.star_half_outlined,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_outline_rounded),
                    iconSize: 20,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  userChoice() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white10,
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                'Whats Your Choice?',
                style:
                    GoogleFonts.muli(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Text(
                  'Share your interests for best recommendations of books within your location range',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.muli(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              //-----------------

              Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 343 / 52,
                  child: Container(
                    child: RaisedButton(
                      color: blackButton,
                      child: new Text(
                        'Personalize',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      onPressed: () async {
                        userPreferences(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  quotes() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        Text(
          '\"Behind every exquisite thing that existed, there was some tragic\"',
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.visible,
          style: GoogleFonts.lato(
              color: blackButton, fontSize: 23, fontStyle: FontStyle.italic),
        ),
        SizedBox(
          height: 15,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            '-Oscar Wilde',
            style: GoogleFonts.lato(color: blackButton, fontSize: 14),
          ),
        )
      ]),
    );
  }
}
