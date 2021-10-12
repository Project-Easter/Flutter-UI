import 'package:books_app/constants/colors.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/screens/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context);
    print('User Choice');
    print(userData);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: <Widget>[
              Text(
                'Whats Your Choice?',
                style:
                    GoogleFonts.mali(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                child: Text(
                  'Share your interests for best recommendations of books within your location range',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mali(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 343 / 52,
                  child: ElevatedButton(
                    child: Text(
                      'Personalize',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      await showGeneralDialog(
                          // barrierColor: Colors.black.withOpacity(0.5),
                          barrierLabel: 'Animation',
                          barrierDismissible: true,
                          transitionDuration: const Duration(milliseconds: 500),
                          context: context,
                          pageBuilder: (BuildContext context,
                                  Animation<double> animation1,
                                  Animation<double> animation2) =>
                              UserPreference(userData));
                    },
                    style: TextButton.styleFrom(
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
