import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UserPreferences.dart';
import '../../Constants/Colors.dart';

class UserChoice extends StatelessWidget {
  const UserChoice({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    print("User Choice");
    print(userData);
    //TODO:Passing Values to User prefs
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white10,
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: <Widget>[
              Text(
                'Whats Your Choice?',
                style:
                    GoogleFonts.muli(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 8, 30, 0),
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
                    child: MaterialButton(
                      color: blackButton,
                      child: new Text(
                        'Personalize',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      onPressed: () async {
                        // userPreferences(context);
                        await showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            barrierLabel: 'Animation',
                            barrierDismissible: true,
                            transitionDuration: Duration(milliseconds: 500),
                            context: context,
                            pageBuilder: (context, animation1, animation2) =>
                                UserPreference(userData));
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
}
