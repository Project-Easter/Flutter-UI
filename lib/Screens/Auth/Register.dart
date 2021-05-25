import 'package:flutter/material.dart';

import '../../Services/auth.dart';
import '../../States/auth_state.dart';
import '../../States/email_state.dart';
import '../../States/password_state.dart';
import '../../Utils/Helpers/not_null.dart';
import '../../Widgets/Auth/auth_button.dart';
import '../../Widgets/Auth/auth_error_message.dart';
import '../../Widgets/Auth/auth_navigation.dart';
import '../../Widgets/Auth/auth_page_title.dart';
import '../../Widgets/text_field.dart';
import 'confirm_email.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends AuthState<RegisterScreen>
    with EmailState<RegisterScreen>, PasswordState<RegisterScreen> {
  final AuthService authService = AuthService();
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
                AuthPageTitle(name: 'Register'),
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
    return authService.register(email, password);
  }

  void onSuccess() {
    // Navigator.pushReplacementNamed(context, Routes.CONFIRM_EMAIL,
    //     arguments: this.email);
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ConfirmEmailScreen(email: email)));
  }
}
