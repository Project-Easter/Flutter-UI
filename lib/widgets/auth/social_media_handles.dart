import 'package:books_app/constants/routes.dart';
import 'package:books_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SocialMediaHandles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)), color: Colors.white),
      child: SizedBox(
        height: 44,
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 44,
              width: 250,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(color: Colors.black87),
                  ),
                  onPressed: () async {
                    print('Google Sign in presws');
                    try {
                      final dynamic res = await FirebaseAuthService().signInWithGoogle();

                      print('This is the google response');
                      print(res);
                      if (res != null) {
                        print(res.toString());
                        Navigator.pushNamed(context, Routes.HOME);
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: SignInButton(
                      Buttons.Google,
                    ),
                  )),
            ),
            // SizedBox(
            //   height: 44,
            //   width: 110,
            //   child: OutlinedButton(
            //     style: OutlinedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //       side: const BorderSide(color: Colors.black87),
            //     ),
            //     onPressed: () async {
            //       FirebaseAuthService()
            //           .signInWithFacebook()
            //           .whenComplete(() {

            //         Navigator.pushNamed(context, Routes.HOME);
            //       });
            //     },
            //     child: const Icon(
            //       FontAwesomeIcons.facebook,
            //       color: Colors.blue,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
