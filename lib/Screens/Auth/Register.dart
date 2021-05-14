import 'dart:math';

import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:books_app/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded)),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 20),
              child: Text(
                "Register",
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 36),
              ),
            ),
            buildLayouts(),
          ],
        ),
      ),
    );
  }

  Widget buildLayouts() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 343 / 52,
              child: TextFormField(
                key: ValueKey('email'),
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                validator: Validator.email,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.all(10),
                ),
                onSaved: (value) {
                  setState(() {
                    _email.text = value;
                  });
                },
                onChanged: (value) {
                  _email.text = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 340 / 52,
              child: Container(
                child: TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  validator: Validator.password,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onSaved: (value) {
                    setState(() {
                      _password.text = value;
                    });
                  },
                  onChanged: (value) {
                    _password.text = value;
                  },
                ),
              ),
            ),
          ),
          CupertinoStyleButton(
            name: 'Register',
            color: blackButton,
            myFunction: () async {
              var isFormValid = _formKey.currentState.validate();

              if (isFormValid) {
                var error = await _authService.register(_email.text, _password.text);

                if (error == null) {
                  return Navigator.pushNamed(context, confirmEmail);
                }

                //TODO: Display error message
              }
            },
          ),
        ],
      ),
    );
  }
}
