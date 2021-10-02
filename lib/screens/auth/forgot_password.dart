import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/button.dart';
import 'package:books_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  // final BackendService authService = BackendService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavigation.from(context),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AuthPageTitle(name: 'Reset password'),
            // AuthErrorMessage(errorMessage: error.toString()),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  EmailTextField(_emailController),
                ],
              ),
            ),
            Button(
              name: 'Continue',
              color: blackButton,
              myFunction: () {
                Navigator.pushReplacementNamed(context, Routes.INITIAL_PAGE);
              },
            )
            // AuthButton(
            //   text: 'Continue',
            //   formKey: formKey,
            //   onClick: onSubmit,
            //   onSuccess: onSuccess,
            //   onError: onError,
            // )
          ],
        ),
      ),
    );
  }

  // Future<String> onSubmit() async {
  //   return authService.forgotPassword(email).toString();
  // }

  // void onSuccess() {
  //   Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
  //       builder: (BuildContext context) => ResetPasswordScreen(email: email)));
  // }
}
