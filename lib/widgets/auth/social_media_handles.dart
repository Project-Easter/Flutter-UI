import 'package:books_app/constants/routes.dart';
import 'package:books_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SocialMediaHandles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 343 / 52,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: Size(width * 0.6, height * 0.08),
              //side: const BorderSide(color: Colors.black87),
            ),
            onPressed: () {},
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 15),
              child: SignInButton(
                Buttons.Google,
                elevation: 0.0,
                onPressed: () async {
                  print('Google Sign in pressed');
                  try {
                    await FirebaseAuthService().signInWithGoogle();
                  } catch (e) {
                    print(e.toString());
                  }
                },
              ),
            )),
      ),
    );
  }
}
