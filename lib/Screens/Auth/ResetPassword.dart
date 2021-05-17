import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/States/ConfirmationCodeState.dart';
import 'package:books_app/States/AuthState.dart';
import 'package:books_app/States/PasswordState.dart';
import 'package:books_app/Utils/Helpers/not_null.dart';
import 'package:books_app/Widgets/Auth/AuthButton.dart';
import 'package:books_app/Widgets/Auth/AuthErrorMessage.dart';
import 'package:books_app/Widgets/Auth/AuthNavigation.dart';
import 'package:books_app/Widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  ResetPassword({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState(email: email);
}

class _ResetPasswordState extends AuthState<ResetPassword>
    with PasswordState<ResetPassword>, ConfirmationCodeState<ResetPassword> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;

  _ResetPasswordState({this.email});

  Future<String> onSubmit() async {
    return await this.authService.resetPassword(this.email, this.password, this.confirmationCode);
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
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthPageTitle(name: 'Reset password'),
                  AuthErrorMessage(errorMessage: this.error),
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
