import 'package:books_app/Services/auth.dart';
import 'package:books_app/States/auth_state.dart';
import 'package:books_app/States/confirmation_code_state.dart';
import 'package:books_app/States/error_state.dart';
import 'package:books_app/Widgets/Auth/auth_button.dart';
import 'package:books_app/Widgets/Auth/auth_error_message.dart';
import 'package:books_app/Widgets/Auth/auth_navigation.dart';
import 'package:books_app/Widgets/Auth/auth_page_title.dart';
import 'package:books_app/Widgets/text_field.dart';
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
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email;

  _ConfirmEmailScreenState(this.email);
  @override
  // TODO: implement context
  BuildContext get context => throw UnimplementedError();

  @override
  // TODO: implement mounted
  bool get mounted => throw UnimplementedError();

  @override
  // TODO: implement widget
  ConfirmEmailScreen get widget => throw UnimplementedError();

  @override
  void activate() {
    // TODO: implement activate
  }

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
  void didUpdateWidget(covariant ConfirmEmailScreen oldWidget) {
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
    return authService.confirmEmail(email, confirmationCode) as String;
  }

  void onSuccess() {
    print('Email confirmed successfully');
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
