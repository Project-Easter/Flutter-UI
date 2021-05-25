import 'package:books_app/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {@required this.text,
      @required this.onClick,
      @required this.onSuccess,
      @required this.onError,
      @required this.formKey});

  final String text;
  final Function onClick;
  final Function onSuccess;
  final Function onError;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(260, 44),
        elevation: 1.5,
        primary: blackButton,
        // primary: Color(0xFF246BFD),
        onPrimary: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () async {
        final bool isFormValid = formKey.currentState.validate();

        if (isFormValid) {
          final dynamic error = await onClick();

          if (error == null) {
            return onSuccess();
          }

          onError(error);
        }
      },
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
