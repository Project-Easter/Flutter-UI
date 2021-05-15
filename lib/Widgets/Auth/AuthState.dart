import 'package:flutter/widgets.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T> {
    String errorMessage;

    void onError(String error) {
    setState(() {
      this.errorMessage = error;
    });
  }
}