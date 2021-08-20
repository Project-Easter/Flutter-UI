import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/States/auth_state.dart';
import 'package:books_app/States/confirmation_code_state.dart';
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

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() =>
      _ResetPasswordScreenState(email: email);
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with
        AuthState<ResetPasswordScreen>,
        PasswordState<ResetPasswordScreen>,
        ConfirmationCodeState<ResetPasswordScreen>,
        ErrorState<ResetPasswordScreen> {
  final BackendService authService = BackendService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;

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
                  AuthErrorMessage(errorMessage: error),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        ConfirmationCodeTextField(
                            onChanged: updateConfirmationCode),
                        PasswordTextField(onChanged: updatePassword)
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
                ].where(notNull).toList()),
          ),
        ));
  }

  Future<String> onSubmit() async {
    return authService
        .resetPassword(email, password, confirmationCode)
        .toString();
  }

  void onSuccess() {
    Navigator.pushNamed(context, Routes.LOGIN);
  }
}
