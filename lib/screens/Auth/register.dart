import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

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
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 36),
              ),
            ),
            buildLayouts(),
            // button(context, blackButton, 'Register', confirmEmail),
            //These buttons don't get the values of the form. Moved this button inside form
            // CupertinoStyleButton(name: 'Register',color: blackButton,
            // myfunction: () async {
            //   Navigator.pushNamed(context, confirmEmail);
            // },
            // ),
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
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.all(10),
                ),
                onSaved: (value) {
                  setState(() {
                    _userEmail.text = value;
                  });
                },
                onChanged: (v) {
                  _userEmail.text = v;
                  print(_userEmail.text);
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
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Password too short must be at least 6 characters long';
                    }
                    return null;
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onSaved: (value) {
                    setState(() {
                      _passWord.text = value;
                    });
                  },
                  onChanged: (v) {
                    _passWord.text = v;
                    print(_passWord.text);
                  },
                ),
              ),
            ),
          ),
          CupertinoStyleButton(
            name: 'Register',
            color: blackButton,
            myFunction: () async {
              print(_userEmail.text);
              print(_passWord.text);
              if (_formKey.currentState.validate()) {
                //Note for Now skipped confirm OTP and username from user.
                //Register with email and password and direct him to login page.
                print(_userEmail.text);
                print(_passWord.text);
                try {
                  dynamic res = await _authService.registerWithEmailAndPassword(
                      _userEmail.text, _passWord.text);
                  if (res != null) {
                    print(res);
                    Navigator.pushNamed(context, loginRoute);
                  }
                } catch (e) {
                  print(e.toString());
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
