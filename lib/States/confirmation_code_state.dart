import 'package:flutter/widgets.dart';

mixin ConfirmationCodeState<T extends StatefulWidget> implements State<T> {
  String confirmationCode;

  void updateConfirmationCode(String confirmationCode) {
    setState(() {
      this.confirmationCode = confirmationCode;
    });
  }
}
