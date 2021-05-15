import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Utils/validator.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
final String email;

  ResetPassword({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState(email);
}

class _ResetPasswordState extends State<ResetPassword> {
    final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String _email;
    String _password;
    String _confirmationCode;

    _ResetPasswordState(this._email);

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
                "Reset Password",
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 36),
              ),
            ),
            buildLayouts(),
             CupertinoStyleButton(
            name: 'Continue',
            color: blackButton,
            myFunction: () async {
              var isFormValid = _formKey.currentState.validate();

              if (isFormValid) {
                var error = await _authService.resetPassword(_email, _password, _confirmationCode);

                if (error == null) {
                  return Navigator.pushNamed(context, loginRoute);
                }

                print(error);
                //TODO: Display error message
              }
            },
          ),
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
                key: ValueKey('verification code'),
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                obscureText: false,
                validator: Validator.confirmationCode,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: 'Confirmation code',
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
                      _confirmationCode = value;
                    });
                  },
                  onChanged: (value) {
                    _confirmationCode = value;
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
                    hintText: 'New password',
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
                      _password = value;
                    });
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
