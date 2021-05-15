import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Widgets/AuthNavigation.dart';
import 'package:books_app/Widgets/AuthPageTitle.dart';
import 'package:books_app/Widgets/TextField.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  ResetPassword({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState(email);
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _confirmationCode;

  _ResetPasswordState(this._email);

  void _updatePassword(String password) {
    setState(() {
      _password = password;
    });
  }

  void _updateConfirmationCode(String confirmationCode) {
    setState(() {
      _confirmationCode = confirmationCode;
    });
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
            buildLayouts(),
            CupertinoStyleButton(
              name: 'Continue',
              color: blackButton,
              myFunction: () async {
                var isFormValid = _formKey.currentState.validate();

                if (isFormValid) {
                  var error = await _authService.resetPassword(_email, _password, _confirmationCode);

                  if (error == null) {
                    return Navigator.pushNamed(context, loginRoute);
                  }

                  print(error);
                  //TODO: Display error message
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLayouts() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ConfirmationCodeTextField(onChanged: this._updateConfirmationCode),
          PasswordTextField(onChanged: this._updatePassword)
        ],
      ),
    );
  }
}
