import 'package:books_app/Constants/Colors.dart';
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

        if (isFormValid) {
          var error = await this.onClick();

          if (error == null) {
            return this.onSuccess();
          }

          this.onError(error);
        }
      },
    );
  }
}
