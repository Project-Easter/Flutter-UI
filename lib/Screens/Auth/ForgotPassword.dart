import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Utils/validator.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

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
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
              child: Text(
                'Enter your email address and we\'ll send you a message',
                textAlign: TextAlign.center,
                softWrap: true,
                style: GoogleFonts.muli(color: Colors.black87, fontSize: 15),
              ),
            ),
            buildLayouts(),
            button(context, blackButton, 'Reset my password', resetPassword),
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
      key: _formKey,
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
                _email.text = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
