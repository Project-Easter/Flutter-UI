import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/auth.dart';
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
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // @override
  // // TODO: implement context
  // BuildContext get context => throw UnimplementedError();

  // @override
  // // TODO: implement mounted
  // bool get mounted => throw UnimplementedError();

  // @override
  // // TODO: implement widget
  // LoginScreen get widget => throw UnimplementedError();

  // @override
  // void activate() {
  //   // TODO: implement activate
  // }

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

  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  // }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   // TODO: implement debugFillProperties
  // }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  // }

  // @override
  // void didUpdateWidget(covariant LoginScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  // }

  Future<String> onSubmit() async {
    return authService.login(email, password);
  }

  void onSuccess() {
    print('Logged in successfully');
  }

  // @override
  // void reassemble() {
  //   // TODO: implement reassemble
  // }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  // }

  // @override
  // DiagnosticsNode toDiagnosticsNode({String name, DiagnosticsTreeStyle style}) {
  //   // TODO: implement toDiagnosticsNode
  //   throw UnimplementedError();
  // }

  // @override
  // String toStringShort() {
  //   // TODO: implement toStringShort
  //   throw UnimplementedError();
  // }
}
