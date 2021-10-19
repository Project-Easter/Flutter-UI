import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget button(
//     BuildContext context, Color buttonColor, String name, String pageRoute) {
//   return Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: AspectRatio(
//       aspectRatio: 343 / 52,
//       child: MaterialButton(
//         color: buttonColor,
//         child: Text(
//           name,
//           style: GoogleFonts.poppins(
//               color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
//         ),
//         onPressed: () async {
//           Navigator.pushNamed(context, pageRoute);
//         },
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       ),
//     ),
//   );
// }

class Button extends StatelessWidget {
  final Color? color;
  final String? name;
  final VoidCallback? myFunction;
  final Color? textColor;

  const Button({this.color, this.name, this.myFunction, this.textColor});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 343 / 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            minimumSize: Size(width * 0.6, height * 0.08),
          ),
          // height: height * 0.08,
          // minWidth: width * 0.6,
          child: Text(
            name!,
            style: GoogleFonts.poppins(
                color: textColor, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          onPressed: myFunction,
        ),
      ),
    );
  }
}
