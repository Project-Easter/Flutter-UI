import 'package:books_app/Screens/Auth/ConfirmEmail.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/States/EmailState.dart';
import 'package:books_app/States/AuthState.dart';
import 'package:books_app/States/PasswordState.dart';
import 'package:books_app/Utils/Helpers/not_null.dart';
import 'package:books_app/Widgets/Auth/AuthButton.dart';
import 'package:books_app/Widgets/Auth/AuthErrorMessage.dart';
import 'package:books_app/Widgets/Auth/AuthNavigation.dart';
import 'package:books_app/Widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/Widgets/TextField.dart';
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
