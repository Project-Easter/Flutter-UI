import 'dart:ffi';

import 'package:books_app/Utils/Validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextField extends StatelessWidget {
  final void Function(String) onChanged;
  final String text;
  final bool obscureText;
  final String Function(String) validator;
  final TextInputType keyboardType;

  TextField(
      {this.onChanged,
      this.text,
      this.obscureText,
      this.validator,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
            ),
          ],
        ),
        child: TextFormField(
          obscureText: obscureText,
          validator: validator,
          textAlign: TextAlign.start,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class EmailTextField extends TextField {
  EmailTextField({@required void Function(String) onChanged})
      : super(
            onChanged: onChanged,
            text: 'Email Address',
            obscureText: false,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress);
}

class PasswordTextField extends TextField {
  PasswordTextField({@required void Function(String) onChanged})
      : super(
            onChanged: onChanged,
            text: 'Password',
            obscureText: true,
            validator: Validator.password);
}

class ConfirmationCodeTextField extends TextField {
  ConfirmationCodeTextField({@required void Function(String) onChanged})
      : super(
            onChanged: onChanged,
            text: 'Confirmation code',
            obscureText: false,
            validator: Validator.confirmationCode);
}
