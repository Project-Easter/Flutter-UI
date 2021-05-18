import 'package:books_app/constants/colors.dart';
import 'package:flutter/widgets.dart';
import '../button.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final Function onSuccess;
  final Function onError;
  final GlobalKey<FormState> formKey;

  AuthButton({@required this.text, @required this.onClick, @required this.onSuccess, @required this.onError, @required this.formKey});

  @override
  Widget build(BuildContext context) {
    return CupertinoStyleButton(
      name: this.text,
      color: blackButton,
      myFunction: () async {
        var isFormValid = this.formKey.currentState.validate();

        if (!isFormValid) return;

        try {
          await this.onClick();
          return this.onSuccess();
        } catch (error) {
          this.onError(error.toString().replaceFirst('Exception: ', ''));
        }
      },
    );
  }
}
