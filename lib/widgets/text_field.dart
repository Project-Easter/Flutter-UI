import 'package:books_app/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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

class UsernameTextField extends AuthField {
  const UsernameTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Username',
            obscureText: false,
            validator: Validator.username,
            controller: controller,
            keyboardType: TextInputType.name);
}

class PhoneTextField extends AuthField {
  const PhoneTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Phone',
            obscureText: false,
            validator: Validator.phone,
            controller: controller,
            keyboardType: TextInputType.phone);
}

class AuthField extends StatelessWidget {
  // final void Function(String) onChanged;
  final String? text;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const AuthField({
    // this.onChanged,
    this.text,
    this.obscureText,
    this.validator,
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
            color: Theme.of(context).backgroundColor,
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
            validator: validator,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText1!.color),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ),
    );
  }
}
