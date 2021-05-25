import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthNavigation {
  static PreferredSizeWidget from(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white10,
      leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_rounded)),
    );
  }
}
