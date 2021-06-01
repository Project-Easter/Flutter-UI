import 'package:books_app/Widgets/button.dart';
import 'package:books_app/constants/colors.dart';
import 'package:flutter/widgets.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final Function onSuccess;
  final Function onError;
  final GlobalKey<FormState> formKey;

  const AuthButton(
      {@required this.text,
      @required this.onClick,
      @required this.onSuccess,
      @required this.onError,
      @required this.formKey});

  @override
  Widget build(BuildContext context) {
    return CupertinoStyleButton(
      name: text,
      color: blackButton,
      myFunction: () async {
        final bool isFormValid = formKey.currentState.validate();
        if (!isFormValid) return;

        try {
          await onClick();
          return onSuccess();
        } catch (error) {
          onError(error.toString().replaceFirst('Exception: ', ''));
        }
      },
    );
  }
}
