import 'package:flutter/material.dart';

class AuthNavigation {
  String dummmy = '';
  static PreferredSizeWidget from(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white10,
      leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_rounded)),
    );
  }
}
