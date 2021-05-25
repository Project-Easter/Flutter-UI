import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/routes.dart';
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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends AuthState<LoginScreen>
    with EmailState<LoginScreen>, PasswordState<LoginScreen> {
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
          children: [
            AuthPageTitle(name: 'Log in'),
            AuthErrorMessage(errorMessage: error),
            Form(
              key: formKey,
              child: Column(
                children: [
                  EmailTextField(onChanged: updateEmail),
                  PasswordTextField(onChanged: updatePassword)
                ],
              ),
            ),
            AuthButton(
              text: 'Sign in',
              formKey: formKey,
              onClick: onSubmit,
              onSuccess: onSuccess,
              onError: onError,
            ),
            buildForgotPasswordButton(),
            buildRegisterButton(),
          ].where(notNull).toList(),
        )),
      ),
    );
  }

  Widget buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        child: Text('Forgot password?',
            style: GoogleFonts.muli(
              color: const Color.fromRGBO(224, 39, 20, 1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        onPressed: () {
          Navigator.pushNamed(context, Routes.FORGOT_PASSWORD);
        },
      ),
    );
  }

  Widget buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topRight,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dont have an account?',
                style: GoogleFonts.muli(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Register',
                style: GoogleFonts.muli(
                    color: const Color.fromRGBO(224, 39, 20, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.REGISTER);
          },
        ),
      ),
    );
  }

  Future<String> onSubmit() async {
    return await authService.login(email, password);
  }

  void onSuccess() {
    print('Logged in successfully');
  }
}
