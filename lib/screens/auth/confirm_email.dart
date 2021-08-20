import 'package:books_app/services/backend_services.dart';
import 'package:books_app/states/auth_state.dart';
import 'package:books_app/states/confirmation_code_state.dart';
import 'package:books_app/states/error_state.dart';
import 'package:books_app/widgets/auth/auth_button.dart';
import 'package:books_app/widgets/auth/auth_error_message.dart';
import 'package:books_app/widgets/auth/auth_navigation.dart';
import 'package:books_app/widgets/auth/auth_page_title.dart';
import 'package:books_app/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String email;
  const ConfirmEmailScreen({Key key, @required this.email}) : super(key: key);
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState(email);
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen>
    with
        AuthState<ConfirmEmailScreen>,
        ErrorState<ConfirmEmailScreen>,
        ConfirmationCodeState<ConfirmEmailScreen> {
  final BackendService authService = BackendService();
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
          children: <Widget>[
            const AuthPageTitle(name: 'Confirm email'),
            AuthErrorMessage(errorMessage: error),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
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
    return authService.confirmEmail(email, confirmationCode) as String;
  }

  void onSuccess() {
    print('Email confirmed successfully');
  }
}
