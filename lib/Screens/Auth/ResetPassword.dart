import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Utils/Helpers/not_null.dart';
import 'package:books_app/Widgets/Auth/AuthButton.dart';
import 'package:books_app/Widgets/Auth/AuthNavigation.dart';
import 'package:books_app/Widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  ResetPassword({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState(email: email);
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;
  String password;
  String confirmationCode;
  String errorMessage;

  _ResetPasswordState({this.email});

  void updatePassword(String password) {
    setState(() {
      this.password = password;
    });
  }

  void updateConfirmationCode(String confirmationCode) {
    setState(() {
      this.confirmationCode = confirmationCode;
    });
  }

  Future<String> onSubmit() async {
    return await this.authService.resetPassword(this.email, this.password, this.confirmationCode);
  }

  void onSuccess() {
    Navigator.pushNamed(context, Routes.LOGIN);
  }

  void onError(String error) {
    setState(() {
      this.errorMessage = error;
    });
  }

  Widget renderErrorMessage() {
    if (this.errorMessage != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
        child: Text(
          this.errorMessage,
          textAlign: TextAlign.center,
          softWrap: true,
          style: GoogleFonts.muli(color: Colors.red, fontSize: 15),
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AuthNavigation.from(context),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthPageTitle(name: 'Reset password'),
                  this.renderErrorMessage(),
                  Form(
                    key: this.formKey,
                    child: Column(
                      children: [
                        ConfirmationCodeTextField(onChanged: this.updateConfirmationCode),
                        PasswordTextField(onChanged: this.updatePassword)
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
                ].where(notNull).toList()),
          ),
        ));
  }
}