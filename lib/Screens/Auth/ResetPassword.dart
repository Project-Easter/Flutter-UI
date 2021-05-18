import 'package:books_app/constants/Routes.dart';
import 'package:books_app/services/Auth.dart';
import 'package:books_app/states/ConfirmationCodeState.dart';
import 'package:books_app/states/AuthState.dart';
import 'package:books_app/states/PasswordState.dart';
import 'package:books_app/utils/Helpers.dart';
import 'package:books_app/widgets/Auth/AuthButton.dart';
import 'package:books_app/widgets/Auth/AuthErrorMessage.dart';
import 'package:books_app/widgets/Auth/AuthNavigation.dart';
import 'package:books_app/widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/widgets/TextField.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  ResetPasswordScreen({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState(email: email);
}

class _ResetPasswordScreenState extends AuthState<ResetPasswordScreen>
    with PasswordState<ResetPasswordScreen>, ConfirmationCodeState<ResetPasswordScreen> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;

  _ResetPasswordScreenState({this.email});

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
