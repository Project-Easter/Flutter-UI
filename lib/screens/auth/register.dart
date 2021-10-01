import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/button.dart';
import 'package:books_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
   {
  // final BackendService authService = BackendService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AuthNavigation.from(context),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const AuthPageTitle(name: 'Register'),
                // AuthErrorMessage(errorMessage: error),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      EmailTextField(),
                      PasswordTextField()
                    ],
                  ),
                ),
                Button(
                  name: 'Sign up',
                  color: blackButton,
                  myFunction: ()async {
                     Navigator.pushNamed(context,Routes.CONFIRM_EMAIL);
                  },
                )
                // AuthButton(
                //   text: 'Sign up',
                //   formKey: formKey,
                //   onClick: onSubmit,
                //   onSuccess: onSuccess,
                //   onError: onError,
                // )
              ],
            ),
          ),
        ));
  }

  // Future<String> onSubmit() async {
  //   return authService.register(email, password) as String;
  // }

  // void onSuccess() {
  //   // Navigator.pushReplacementNamed(context, Routes.CONFIRM_EMAIL,
  //   //     arguments: this.email);
  //   Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
  //       builder: (BuildContext context) => ConfirmEmailScreen(email: email)));
  // }
}
