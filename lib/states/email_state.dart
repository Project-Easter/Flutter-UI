import 'package:flutter/widgets.dart';

mixin EmailState<T extends StatefulWidget> implements State<T> {
  String email;

  void updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }
}
