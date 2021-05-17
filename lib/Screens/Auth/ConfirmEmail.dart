import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/States/ConfirmationCodeState.dart';
import 'package:books_app/States/AuthState.dart';
import 'package:books_app/Widgets/Auth/AuthButton.dart';
import 'package:books_app/Widgets/Auth/AuthErrorMessage.dart';
import 'package:books_app/Widgets/Auth/AuthNavigation.dart';
import 'package:books_app/Widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String email;

  ConfirmEmailScreen({Key key, @required this.email}) : super(key: key);

  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState(email);
}

class _ConfirmEmailScreenState extends AuthState<ConfirmEmailScreen> with ConfirmationCodeState<ConfirmEmailScreen> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;

  _ConfirmEmailScreenState(this.email);

  Future<String> onSubmit() async {
    return await authService.confirmEmail(this.email, this.confirmationCode);
  }

  void onSuccess() {
    Navigator.pushNamed(this.context, Routes.HOME);
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
            AuthPageTitle(name: 'Confirm your email'),
            AuthErrorMessage(errorMessage: this.error),
            Form(
              key: this.formKey,
              child: Column(
                children: [ConfirmationCodeTextField(onChanged: this.updateConfirmationCode)],
              ),
            ),
            AuthButton(
              text: 'Continue',
              formKey: this.formKey,
              onClick: this.onSubmit,
              onSuccess: this.onSuccess,
              onError: this.onError,
            ),
          ],
        ),
      ),
    );
  }
}
