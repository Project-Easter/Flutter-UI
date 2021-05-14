import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:books_app/Utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Navigator.pushNamed(context, startupPage);
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
                'Login',
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 36),
              ),
            ),
            buildLayouts(),
            forgetButton(),
            registerButton(),
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
            padding: EdgeInsets.all(5),
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
                onChanged: (v) {
                  _email.text = v;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: AspectRatio(
              aspectRatio: 343 / 52,
              child: TextFormField(
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
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
                onChanged: (v) {
                  _password.text = v;
                },
              ),
            ),
          ),
          CupertinoStyleButton(
            name: 'Sign In',
            color: blackButton,
            myFunction: () async {
              var isFormValid = _formKey.currentState.validate();

              if (isFormValid) {
                var error = await _authService.signInWithEmailAndPassword(_email.text, _password.text);

                if (error == null) {
                  return Navigator.pushNamed(context, home);
                }

                print(error);
                //TODO: Display error message
              }
            },
          ),
        ],
      ),
    );
  }

  Widget forgetButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        child: Text("Forgot password?",
            style: GoogleFonts.muli(
              color: Color.fromRGBO(224, 39, 20, 1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        onPressed: () async {
          Navigator.pushNamed(context, forgotPassword);
        },
      ),
    );
  }

  Widget registerButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topRight,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dont have an account?',
                style: GoogleFonts.muli(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Register',
                style:
                    GoogleFonts.muli(color: Color.fromRGBO(224, 39, 20, 1), fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          onPressed: () async {
            Navigator.pushNamed(context, registerRoute);
          },
        ),
      ),
    );
  }
}
