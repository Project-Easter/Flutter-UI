import 'package:books_app/services/auth.dart';
import 'package:books_app/states/confirmation_code_state.dart';
import 'package:books_app/states/auth_state.dart';
import 'package:books_app/widgets/auth/auth_button.dart';
import 'package:books_app/widgets/auth/auth_error_message.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String email;

  ConfirmEmailScreen({Key key, @required this.email}) : super(key: key);

  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState(email);
}

class _ConfirmEmailScreenState extends AuthState<ConfirmEmailScreen> with ConfirmationCodeState<ConfirmEmailScreen> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;

  _ConfirmEmailScreenState(this.email);

  Future<String> onSubmit() async {
    return await authService.confirmEmail(this.email, this.confirmationCode);
  }

  void onSuccess() {
    print('Email confirmed successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavigation.from(context),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthPageTitle(name: 'Confirm email'),
            AuthErrorMessage(errorMessage: this.error),
            Form(
              key: this.formKey,
              child: Column(
                children: [ConfirmationCodeTextField(onChanged: this.updateConfirmationCode)],
              ),
            ),
            AuthButton(
              text: 'Continue',
              formKey: this.formKey,
              onClick: this.onSubmit,
              onSuccess: this.onSuccess,
              onError: this.onError,
            ),
          ],
        ),
      ),
    );
  }
}
