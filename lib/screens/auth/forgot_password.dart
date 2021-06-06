import 'package:books_app/Screens/Auth/reset_password.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/States/auth_state.dart';
import 'package:books_app/States/email_state.dart';
import 'package:books_app/States/error_state.dart';
import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/Widgets/Auth/auth_button.dart';
import 'package:books_app/Widgets/Auth/auth_error_message.dart';
import 'package:books_app/Widgets/Auth/auth_navigation.dart';
import 'package:books_app/Widgets/Auth/auth_page_title.dart';
import 'package:books_app/Widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with
        AuthState<ForgotPasswordScreen>,
        EmailState<ForgotPasswordScreen>,
        ErrorState<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  // TODO: implement context
  BuildContext get context => throw UnimplementedError();

  @override
  // TODO: implement mounted
  bool get mounted => throw UnimplementedError();

  @override
  // TODO: implement widget
  ForgotPasswordScreen get widget => throw UnimplementedError();

  @override
  void activate() {
    // TODO: implement activate
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavigation.from(context),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AuthPageTitle(name: 'Reset password'),
            AuthErrorMessage(errorMessage: error.toString()),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  EmailTextField(onChanged: updateEmail),
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
          ].where(notNull).toList(),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  void didUpdateWidget(covariant ForgotPasswordScreen oldWidget) {
    // TODO: implement didUpdateWidget
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  Future<String> onSubmit() async {
    return authService.forgotPassword(email).toString();
  }

  void onSuccess() {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (context) => ResetPasswordScreen(email: email)));
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
  }

  @override
  DiagnosticsNode toDiagnosticsNode({String name, DiagnosticsTreeStyle style}) {
    // TODO: implement toDiagnosticsNode
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }
}
