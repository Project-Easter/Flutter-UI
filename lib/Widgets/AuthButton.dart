import 'package:books_app/Constants/Colors.dart';
import 'package:flutter/widgets.dart';
import 'button.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final Function onSuccess;
  final GlobalKey<FormState> formKey;

  AuthButton({this.text, this.onClick, this.onSuccess, this.formKey});

  @override
  Widget build(BuildContext context) {
    return CupertinoStyleButton(
      name: this.text,
      color: blackButton,
      myFunction: () async {
        var isFormValid = this.formKey.currentState.validate();

        if (isFormValid) {
          var error = await this.onClick();

          if (error == null) {
            return this.onSuccess();
          }

          print(error);
        }
      },
    );
  }
}
