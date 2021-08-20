import 'package:books_app/Screens/Auth/confirm_email.dart';
import 'package:books_app/States/auth_state.dart';
import 'package:books_app/States/email_state.dart';
import 'package:books_app/States/error_state.dart';
import 'package:books_app/States/password_state.dart';
import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/Widgets/Auth/auth_button.dart';
import 'package:books_app/Widgets/Auth/auth_error_message.dart';
import 'package:books_app/Widgets/Auth/auth_navigation.dart';
import 'package:books_app/Widgets/Auth/auth_page_title.dart';
import 'package:books_app/Widgets/text_field.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/backend_services.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with
        AuthState<RegisterScreen>,
        EmailState<RegisterScreen>,
        PasswordState<RegisterScreen>,
        ErrorState<RegisterScreen> {
  final BackendService authService = BackendService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AuthNavigation.from(context),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const AuthPageTitle(name: 'Register'),
                AuthErrorMessage(errorMessage: error),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      EmailTextField(onChanged: updateEmail),
                      PasswordTextField(onChanged: updatePassword)
                    ],
                  ),
                ),
                AuthButton(
                  text: 'Sign up',
                  formKey: formKey,
                  onClick: onSubmit,
                  onSuccess: onSuccess,
                  onError: onError,
                )
              ].where(notNull).toList(),
            ),
          ),
        ));
  }

  Future<String> onSubmit() async {
    return authService.register(email, password) as String;
  }

  void onSuccess() {
    // Navigator.pushReplacementNamed(context, Routes.CONFIRM_EMAIL,
    //     arguments: this.email);
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ConfirmEmailScreen(email: email)));
  }
}
