import 'package:books_app/Screens/Auth/ResetPassword.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Utils/Helpers/not_null.dart';
import 'package:books_app/Widgets/Auth/AuthButton.dart';
import 'package:books_app/Widgets/Auth/AuthErrorMessage.dart';
import 'package:books_app/Widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/Widgets/Auth/AuthState.dart';
import 'package:books_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends AuthState<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  String email;

  void updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  Future<String> onSubmit() async {
    return await this.authService.forgotPassword(email);
  }

  void onSuccess() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword(email: email)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthPageTitle(name: 'Reset password'),
            AuthErrorMessage(errorMessage: this.errorMessage),
            Form(
              key: this.formKey,
              child: Column(
                children: [
                  EmailTextField(onChanged: this.updateEmail),
                ],
              ),
            ),
            AuthButton(
              text: 'Continue',
              formKey: this.formKey,
              onClick: this.onSubmit,
              onSuccess: this.onSuccess,
              onError: this.onError,
            )
          ].where(notNull).toList(),
        ),
      ),
    );
  }
}
