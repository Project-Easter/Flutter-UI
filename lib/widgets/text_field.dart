import 'package:books_app/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationCodeTextField extends AuthField {
  const ConfirmationCodeTextField()
      : super(
            // onChanged: onChanged,
            text: 'Confirmation code',
            obscureText: false,
            validator: Validator.confirmationCode);
}

class EmailTextField extends AuthField {
  const EmailTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Email Address',
            obscureText: false,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress,
            controller: controller);
}

class PasswordTextField extends AuthField {
  const PasswordTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Password',
            obscureText: true,
            validator: Validator.password,
            controller: controller);
}

class AuthField extends StatelessWidget {
  // final void Function(String) onChanged;
  final String? text;
  final bool? obscureText;
  final String? Function(String) validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const AuthField({
    // this.onChanged,
    this.text,
    this.obscureText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.controller,
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
            controller: controller,
            obscureText: obscureText!,
            validator: validator as String? Function(String?),
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
