import 'package:books_app/Constants/routes.dart';
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
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with
        AuthState<LoginScreen>,
        EmailState<LoginScreen>,
        PasswordState<LoginScreen>,
        ErrorState<LoginScreen> {
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
            const AuthPageTitle(name: 'Log in'),
            AuthErrorMessage(errorMessage: error.toString()),
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
            children: <Widget>[
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
    return authService.login(email, password);
  }

  Future<Object> onSuccess() {
    print('Logged in successfully');
    return Navigator.pushNamed(context, Routes.DASHBOARD);
  }
}
