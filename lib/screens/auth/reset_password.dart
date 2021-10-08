import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/button.dart';
import 'package:books_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email;

  const ResetPasswordScreen({required Key key, required this.email})
      : super(key: key);

  @override
  _ResetPasswordScreenState createState() =>
      _ResetPasswordScreenState(email: email!);
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // final BackendService authService = BackendService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  String? email;

  _ResetPasswordScreenState({this.email});

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
                  const AuthPageTitle(name: 'Reset password'),
                  // AuthErrorMessage(errorMessage: error),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        ConfirmationCodeTextField(),
                        PasswordTextField(_passwordController)
                      ],
                    ),
                  ),
                  Button(
                    myFunction: () async {
                      Navigator.pushReplacementNamed(
                          context, Routes.INITIAL_PAGE);
                    },
                    color: blackButton,
                    name: 'Continue',
                    // formKey: formKey,
                    // onClick: onSubmit,
                    // onSuccess: onSuccess,
                    // onError: onError,
                  )
                ]),
          ),
        ));
  }

  // Future<String> onSubmit() async {
  //   return authService
  //       .resetPassword(email, password, confirmationCode)
  //       .toString();
  // }

  // void onSuccess() {
  //   Navigator.pushNamed(context, Routes.LOGIN);
  // }
}
