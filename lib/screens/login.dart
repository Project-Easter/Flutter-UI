import 'package:books_app/screens/register.dart';
import 'package:flutter/material.dart';

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
            child: Image.asset(
              "images/icon.PNG",
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Log In",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            buildLayouts(),
            SizedBox(
              height: 20.0,
            ),
            loginButton(),
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
          TextFormField(
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
            decoration: InputDecoration(
                hintText: 'Email',
                focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder),
            onSaved: (value) {
              _userEmail.text = value;
            },
          ),
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
            key: ValueKey('password'),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty || value.length < 6) {
                return 'Password too short must be at least 6 characters long';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Password',
                focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder),
            onSaved: (value) {
              _passWord.text = value;
            },
          ),
          SizedBox(
            height: 8.0,
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
