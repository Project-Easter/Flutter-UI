// import 'package:books_app/constants/colors.dart';
// import 'package:books_app/constants/routes.dart';
// import 'package:books_app/widgets/app_bar.dart';
// import 'package:books_app/widgets/button.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class EnterMobile extends StatefulWidget {
//   const EnterMobile({Key key}) : super(key: key);

//   @override
//   _EnterMobileState createState() => _EnterMobileState();
// }

// class _EnterMobileState extends State<EnterMobile> {
//   final GlobalKey<FormState> _mobileVerify = GlobalKey<FormState>();

//   final TextEditingController _mobile = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(context),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Text(
//                 'Add your Book',
//                 style: GoogleFonts.poppins(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 30),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: _mobileVerify,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 3),
//                       child: TextFormField(
//                         controller: _mobile,
//                         validator: (String value) {
//                           if (value.isEmpty) {
//                             return 'Please enter a valid mobile no';
//                           }
//                           if (value.length != 10) {
//                             return 'Please enter a 10 digit value';
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.number,
//                         autocorrect: false,
//                         key: const ValueKey<String>('Mobile No'),
//                         decoration: InputDecoration(
//                           hintText: 'Enter Mobile No',
//                           hintStyle: GoogleFonts.poppins(
//                             fontSize: 14,
//                           ),
//                         ),
//                         onFieldSubmitted: (String value) {
//                           setState(() {
//                             _mobile.text = value;
//                           });
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       // child: button(context, blackButton, 'Add your Book', ''),
//                       child: Button(
//                         name: 'Send OTP',
//                         color: blackButton,
//                         myFunction: () async {
//                           if (_mobileVerify.currentState.validate()) {
//                             _mobileVerify.currentState.save();

//                             Navigator.pushReplacementNamed(context, Routes.OTP);

//                             final SnackBar snackbar = SnackBar(
//                               content: const Text(
//                                   'Your mobile no has been verified'),
//                               action: SnackBarAction(
//                                 label: 'Close',
//                                 onPressed: () {
//                                   ScaffoldMessenger.of(context)
//                                       .hideCurrentSnackBar();
//                                 },
//                               ),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackbar);
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
