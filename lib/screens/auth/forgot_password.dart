import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/services/auth.dart';
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

  String? _message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavigation.from(context),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            showAlert(),
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
              myFunction: () async {
                await FirebaseAuthService()
                    .resetPassword(_emailController.text);
                setState(() {
                  _message =
                      'Password reset link has been sent to you on email ${_emailController.text}.You will be redirected to signIn page';
                });

                print(_message);
                await Future<dynamic>.delayed(
                    const Duration(seconds: 4), () {});
                Navigator.pushReplacementNamed(context, Routes.INITIAL_PAGE);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_message != null) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          color: Colors.amberAccent,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline),
              ),
              Expanded(
                child: Text(
                  _message!,
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _message = '';
                    });
                  },
                ),
              )
            ],
          ),
        ),
      );
    } else
      return Container();
  }
}
