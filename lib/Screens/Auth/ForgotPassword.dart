import 'package:books_app/Screens/Auth/ResetPassword.dart';
import 'package:books_app/services/Auth.dart';
import 'package:books_app/states/EmailState.dart';
import 'package:books_app/states/AuthState.dart';
import 'package:books_app/utils/Helpers.dart';
import 'package:books_app/widgets/Auth/AuthButton.dart';
import 'package:books_app/widgets/Auth/AuthErrorMessage.dart';
import 'package:books_app/widgets/Auth/AuthNavigation.dart';
import 'package:books_app/widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/widgets/TextField.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends AuthState<ForgotPasswordScreen> with EmailState<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  Future<String> onSubmit() async {
    return await this.authService.forgotPassword(this.email);
  }

  void onSuccess() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: this.email)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavigation.from(context),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthPageTitle(name: 'Reset password'),
            AuthErrorMessage(errorMessage: this.error),
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
