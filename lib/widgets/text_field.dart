import 'package:books_app/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends AuthField {
  const EmailTextField()
      : super(
            // onChanged: onChanged,
            text: 'Email Address',
            obscureText: false,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress);
}

class PasswordTextField extends AuthField {
  const PasswordTextField()
      : super(
            // onChanged: onChanged,
            text: 'Password',
            obscureText: true,
            validator: Validator.password);
}

class AuthField extends StatelessWidget {
  // final void Function(String) onChanged;
  final String text;
  final bool obscureText;
  final String Function(String) validator;
  final TextInputType keyboardType;

  const AuthField({
    // this.onChanged,
    this.text,
    this.obscureText,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // TextEditingController _controller;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 343 / 52,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const <BoxShadow>[
              BoxShadow(
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
          ),
        ),
      ),
    );
  }
}
