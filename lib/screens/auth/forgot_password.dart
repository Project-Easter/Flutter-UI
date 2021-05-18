import 'package:books_app/screens/auth/reset_password.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/states/email_state.dart';
import 'package:books_app/states/auth_state.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:books_app/widgets/auth/auth_button.dart';
import 'package:books_app/widgets/auth/auth_error_message.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/text_field.dart';
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
