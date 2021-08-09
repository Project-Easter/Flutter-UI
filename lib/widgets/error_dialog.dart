import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Error'),
    content: Text('\n$message'),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('Yes'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // show the dialog
  showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
