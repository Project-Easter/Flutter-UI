import 'package:books_app/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Text('Signout'),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pop();
          },
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          child: Text('Signout from Facebook'),
          onPressed: () {
            AuthService().facebookSignout();
            Navigator.of(context).pop();
          },
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          child: Text('Signout from Google'),
          onPressed: () {
            AuthService().googleSignout();
            Navigator.of(context).pop();
          },
        ),
      ],
    )));
  }
}
