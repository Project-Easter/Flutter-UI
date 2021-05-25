import 'package:flutter/material.dart';

import '../../Services/auth.dart';
import '../../States/auth_state.dart';
import '../../States/confirmation_code_state.dart';
import '../../Widgets/Auth/auth_button.dart';
import '../../Widgets/Auth/auth_error_message.dart';
import '../../Widgets/Auth/auth_navigation.dart';
import '../../Widgets/Auth/auth_page_title.dart';
import '../../Widgets/text_field.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String email;
  const ConfirmEmailScreen({Key key, @required this.email}) : super(key: key);
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState(email);
}

class _ConfirmEmailScreenState extends AuthState<ConfirmEmailScreen>
    with ConfirmationCodeState<ConfirmEmailScreen> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email;

  _ConfirmEmailScreenState(this.email);
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

  Future<String> onSubmit() async {
    return authService.confirmEmail(email, confirmationCode);
  }

  void onSuccess() {
    print('Email confirmed successfully');
  }
}
