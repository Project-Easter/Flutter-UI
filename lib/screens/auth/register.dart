import 'package:books_app/screens/auth/confirm_email.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/states/email_state.dart';
import 'package:books_app/states/auth_state.dart';
import 'package:books_app/states/password_state.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:books_app/widgets/auth/auth_button.dart';
import 'package:books_app/widgets/auth/auth_error_message.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends AuthState<RegisterScreen> with EmailState<RegisterScreen>, PasswordState<RegisterScreen> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String> onSubmit() async {
    return await this.authService.register(this.email, this.password);
  }

  void onSuccess() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmEmailScreen(email: this.email)));
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
                AuthPageTitle(name: 'Register'),
                AuthErrorMessage(errorMessage: this.error),
                Form(
                  key: this.formKey,
                  child: Column(
                    children: [EmailTextField(onChanged: this.updateEmail), PasswordTextField(onChanged: this.updatePassword)],
                  ),
                ),
                AuthButton(
                  text: 'Sign up',
                  formKey: this.formKey,
                  onClick: this.onSubmit,
                  onSuccess: this.onSuccess,
                  onError: this.onError,
                )
              ].where(notNull).toList(),
            ),
          ),
        ));
  }
}
