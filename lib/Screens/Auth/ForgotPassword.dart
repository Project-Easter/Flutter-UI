import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Screens/Auth/ResetPassword.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Utils/validator.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  String _email;

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
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 20),
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 35),
              ),
            ),
            buildLayouts(),
            CupertinoStyleButton(
              name: 'Continue',
              color: blackButton,
              myFunction: () async {
                var isFormValid = formKey.currentState.validate();

                if (isFormValid) {
                  var error = await authService.sendResetPasswordMail(_email);

                  if (error == null) {
                    return Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => ResetPassword(email: _email)));
                  }

                  print(error);
                  //TODO: Display error message
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLayouts() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AspectRatio(
          aspectRatio: 343 / 52,
          child: TextFormField(
            key: ValueKey('resetPassword'),
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            enableSuggestions: false,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: 'Email Address',
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
                _email = value;
              });
            },
            onChanged: (value) {
              _email = value;
            },
          ),
        ),
      ),
    );
  }
}
