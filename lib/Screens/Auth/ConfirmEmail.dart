import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Utils/validator.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String email;

  ConfirmEmailScreen({Key key, @required this.email}) : super(key: key);

  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState(email);
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _confirmationCode;

  _ConfirmEmailScreenState(this._email);

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
                'Email confirmation',
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
                  var error = await _authService.confirmEmail(_email, _confirmationCode);

                  if (error == null) {
                    return print('Email confirmed successfully');
                    // return Navigator.pushNamed(context, confirmEmail);
                  }

                  print(error);
                  //TODO: Display error message
                }
              },
            ),
            SizedBox(
              height: 20.0,
            )
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
            key: ValueKey('_confirmationCode'),
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            enableSuggestions: false,
            validator: Validator.confirmationCode,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: 'Enter your confirmation code',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
              ),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
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
    );
  }
}
