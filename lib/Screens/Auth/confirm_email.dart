import 'package:books_app/Services/auth.dart';
import 'package:books_app/States/auth_state.dart';
import 'package:books_app/States/confirmation_code_state.dart';
import 'package:books_app/Widgets/Auth/auth_button.dart';
import 'package:books_app/Widgets/Auth/auth_error_message.dart';
import 'package:books_app/Widgets/Auth/auth_navigation.dart';
import 'package:books_app/Widgets/Auth/auth_page_title.dart';
import 'package:books_app/Widgets/text_field.dart';
import 'package:flutter/material.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({Key key, @required this.email}) : super(key: key);
  final String email;
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState(email);
}

class _ConfirmEmailScreenState extends AuthState<ConfirmEmailScreen>
    with ConfirmationCodeState<ConfirmEmailScreen> {
  _ConfirmEmailScreenState(this.email);
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;
  Future<String> onSubmit() async {
    return authService.confirmEmail(email, confirmationCode);
  }

  void onSuccess() {
    print('Email confirmed successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavigation.from(context),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthPageTitle(name: 'Confirm email'),
            AuthErrorMessage(errorMessage: error),
            Form(
              key: formKey,
              child: Column(
                children: [
                  ConfirmationCodeTextField(onChanged: updateConfirmationCode)
                ],
              ),
            ),
            AuthButton(
              text: 'Continue',
              formKey: formKey,
              onClick: onSubmit,
              onSuccess: onSuccess,
              onError: onError,
            ),
          ],
        ),
      ),
    );
  }
}
