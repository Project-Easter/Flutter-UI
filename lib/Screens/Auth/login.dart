import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:books_app/screens/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        leading: FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
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
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 36),
              ),
            ),
            buildLayouts(),
            button(context, blackButton, 'Log In', registerRoute),
            SizedBox(
              height: 20.0,
            ),
            forgetButton()
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
                  _userEmail.text = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 343 / 52,
              child: TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return 'Password too short must be at least 6 characters long';
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
                  _passWord.text = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Container(
      height: MediaQuery.of(context).size.height / 13.5,
      width: MediaQuery.of(context).size.width / 1.0,
      child: FlatButton(
        color: Theme.of(context).buttonColor,
        child: new Text(
          'Log In',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        shape: Theme.of(context).buttonTheme.shape,
      ),
    );
  }

  Widget forgetButton() {
    return Container(
      child: FlatButton(
        child: Text(
          "Forgot  your password?",
          style: TextStyle(color: Color.fromRGBO(224, 39, 20, 1), fontSize: 14),
        ),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
      ),
    );
  }
}
