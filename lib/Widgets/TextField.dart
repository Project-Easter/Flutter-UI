import 'package:books_app/Utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextField extends StatelessWidget {
  final Function onChanged;
  final String text;
  final bool obscureText;
  final Function validator;
  final TextInputType keyboardType;

  TextField({this.onChanged, this.text, this.obscureText, this.validator, this.keyboardType: TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 340 / 52,
        child: Container(
          child: TextFormField(
            obscureText: this.obscureText,
            validator: this.validator,
            textAlign: TextAlign.start,
            keyboardType: this.keyboardType,
            decoration: InputDecoration(
              hintText: this.text,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
              ),
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
              enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
              contentPadding: EdgeInsets.all(10),
            ),
            onChanged: this.onChanged,
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends TextField {
  EmailTextField({@required Function onChanged})
      : super(
            onChanged: onChanged,
            text: 'Email Address',
            obscureText: false,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress);
}

class PasswordTextField extends TextField {
  PasswordTextField({@required Function onChanged})
      : super(onChanged: onChanged, text: 'Password', obscureText: true, validator: Validator.password);
}

class ConfirmationCodeTextField extends TextField {
  ConfirmationCodeTextField({@required Function onChanged})
      : super(
            onChanged: onChanged, text: 'Confirmation code', obscureText: false, validator: Validator.confirmationCode);
}
