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
  final Color color;
  final String name;
  final VoidCallback myFunction;

  const Button({this.color, this.name, this.myFunction});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 343 / 52,
        child: MaterialButton(
          height: height * 0.08,
          minWidth: width * 0.6,
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
