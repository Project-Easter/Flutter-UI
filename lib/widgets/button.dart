import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget button(
    BuildContext context, Color buttonColor, String name, String pageRoute) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: AspectRatio(
      aspectRatio: 343 / 52,
      child: Container(
        child: MaterialButton(
          color: buttonColor,
          child: new Text(
            name,
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          onPressed: () async {
            Navigator.pushNamed(context, pageRoute);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    ),
  );
}

class CupertinoStyleButton extends StatelessWidget {
  final Color color;
  final String name;
  final VoidCallback myFunction;

  const CupertinoStyleButton({this.color, this.name, this.myFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 343 / 52,
        child: MaterialButton(
          color: color,
          child: Text(
            name,
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          onPressed: myFunction,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
