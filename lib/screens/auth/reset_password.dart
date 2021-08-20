import 'package:books_app/constants/routes.dart';
import 'package:books_app/services/backend_services.dart';
import 'package:books_app/states/auth_state.dart';
import 'package:books_app/states/confirmation_code_state.dart';
import 'package:books_app/states/error_state.dart';
import 'package:books_app/states/password_state.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:books_app/widgets/auth/auth_button.dart';
import 'package:books_app/widgets/auth/auth_error_message.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/text_field.dart';
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
