import 'package:books_app/Screens/Auth/reset_password.dart';
import 'package:books_app/States/auth_state.dart';
import 'package:books_app/States/email_state.dart';
import 'package:books_app/States/error_state.dart';
import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/Widgets/Auth/auth_button.dart';
import 'package:books_app/Widgets/Auth/auth_error_message.dart';
import 'package:books_app/Widgets/Auth/auth_navigation.dart';
import 'package:books_app/Widgets/Auth/auth_page_title.dart';
import 'package:books_app/Widgets/text_field.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/backend_services.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with
        AuthState<ForgotPasswordScreen>,
        EmailState<ForgotPasswordScreen>,
        ErrorState<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BackendService authService = BackendService();

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
            AuthErrorMessage(errorMessage: error.toString()),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  EmailTextField(onChanged: updateEmail),
                ],
              ),
            ),
            AuthButton(
              text: 'Continue',
              formKey: formKey,
              onClick: onSubmit,
              onSuccess: onSuccess,
              onError: onError,
            )
          ].where(notNull).toList(),
        ),
      ),
    );
  }

  Future<String> onSubmit() async {
    return authService.forgotPassword(email).toString();
  }

  void onSuccess() {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ResetPasswordScreen(email: email)));
  }
}
