import 'package:books_app/Constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/States/auth_state.dart';
import 'package:books_app/States/email_state.dart';
import 'package:books_app/States/error_state.dart';
import 'package:books_app/States/password_state.dart';
import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/Utils/size_config.dart';
import 'package:books_app/Widgets/Auth/auth_button.dart';
import 'package:books_app/Widgets/text_field.dart';
import 'package:books_app/widgets/auth/social_media_handles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with
        AuthState<InitialScreen>,
        EmailState<InitialScreen>,
        PasswordState<InitialScreen>,
        ErrorState<InitialScreen> {
  //Init AuthService

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Container(
        color: const Color.fromRGBO(88, 188, 130, 1),
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 30, right: 15.0),
                  //     child: _skipButton(),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    'assets/images/ExplrLogo(150x150).png',
                    scale: 1.4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Explr',
                    style: GoogleFonts.muli(
                        color: blackButton,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          EmailTextField(onChanged: updateEmail),
                          PasswordTextField(onChanged: updatePassword)
                        ],
                      ),
                    ),
                  ),
                  buildForgotPasswordButton(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: AuthButton(
                      text: 'Sign in',
                      formKey: formKey,
                      onClick: onSubmit,
                      onSuccess: onSuccess,
                      onError: onError,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 1,
                        width: 120,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        ' or you can ',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(height: 1, width: 120, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _signUpwithEmail(),
                  const SizedBox(height: 10),
                  SocialMediaHandles(),
                  const SizedBox(height: 40),
                ].where(notNull).toList(),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text('Forgot password?',
            textAlign: TextAlign.center,
            style: GoogleFonts.muli(
              color: const Color.fromRGBO(224, 39, 20, 1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        onPressed: () {
          Navigator.pushNamed(context, Routes.FORGOT_PASSWORD);
        },
      ),
    );
  }

  Future<String> onSubmit() async {
    return AuthService().login(_emailController.text, _passwordController.text);
  }

  void onSuccess() {
    print('Logged in successfully');
    Navigator.pushNamed(context, Routes.HOME);
  }

  Widget _signUpwithEmail() {
    return SizedBox(
      height: 44,
      width: 250,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // primary: Color(0xFF246BFD),
          primary: blackButton,
        ),
        onPressed: () async {
          Navigator.popAndPushNamed(context, Routes.REGISTER);
        },
        icon: const Icon(
          Icons.mail_outline_outlined,
          color: Colors.white,
        ),
        label: Text(
          'Sign up with email',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Widget _skipButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       print('Skip button pressed');
  //       Navigator.pushNamed(context, Routes.DASHBOARD);
  //     },
  //     style: ElevatedButton.styleFrom(
  //       primary: blackButton,
  //       onPrimary: Colors.white12,
  //       minimumSize: const Size(55, 24.75),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  //     ),
  //     child: Text(
  //       'Skip',
  //       style: GoogleFonts.poppins(
  //           color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
  //     ),
  //   );
  // }

}
