import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Widgets/AuthButton.dart';
import 'package:books_app/Widgets/AuthNavigation.dart';
import 'package:books_app/Widgets/AuthPageTitle.dart';
import 'package:books_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  ResetPassword({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState(email: email);
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String password;
  String confirmationCode;

  _ResetPasswordState({this.email});

  void _updatePassword(String password) {
    setState(() {
      this.password = password;
    });
  }

  void _updateConfirmationCode(String confirmationCode) {
    setState(() {
      this.confirmationCode = confirmationCode;
    });
  }

  Future<String> onSubmit() async {
    return await _authService.resetPassword(this.email, this.password, this.confirmationCode);
  }

  void onSuccess() {
    Navigator.pushNamed(context, Routes.LOGIN);
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ConfirmationCodeTextField(onChanged: this._updateConfirmationCode),
                  PasswordTextField(onChanged: this._updatePassword)
                ],
              ),
            ),
            AuthButton(
              text: 'Continue',
              formKey: this._formKey,
            )
            // CupertinoStyleButton(
            //   name: 'Continue',
            //   color: blackButton,
            //   myFunction: () async {
            //     var isFormValid = _formKey.currentState.validate();

            //     if (isFormValid) {
            //   var error = await _authService.resetPassword(_email, _password, _confirmationCode);

            //       if (error == null) {
            //         return Navigator.pushNamed(context, loginRoute);
            //       }

            //       print(error);
            //       //TODO: Display error message
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
