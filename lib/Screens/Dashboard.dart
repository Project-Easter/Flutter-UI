import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Screens/UserPreferences.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userChoice(),
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
        )));
  }

  userChoice() {
    return Column(
      children: <Widget>[
        Text(
          'Whats Your Choice?',
          style: GoogleFonts.poppins(),
        ),
        Text(
          'Share your interests for best recommendations of books within your location range',
          softWrap: true,
          textAlign: TextAlign.center,
          style: GoogleFonts.muli(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        //-----------------

        Padding(
          padding: const EdgeInsets.all(20.0),
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
    );
  }
}
