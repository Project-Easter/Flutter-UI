import 'package:books_app/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/painting.dart';
import 'package:books_app/Widgets/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:books_app/Services/auth.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _contactEditingController = new TextEditingController();
  String _dialCode = '';

  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  //Alert dialogue to show error and response
  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Container(
        color: Color.fromRGBO(157, 206, 255, 1),
        child: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset('assets/library-01.png'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, right: 15.0),
                        child: _skipButton(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome to',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Barter Books',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Easiest way to exchange your books',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'with others',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                _enterMobileNo(),
                SizedBox(height: 10),
                _sendOTP(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: 120,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      ' or you can ',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(height: 1, width: 120, color: Colors.black),
                  ],
                ),
                SizedBox(height: 20),
                _signUpwithEmail(),
                SizedBox(height: 10),
                _socialMediaHandles(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _enterMobileNo() {
    return Container(
      alignment: Alignment.center,
      height: 44,
      width: 260,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          CountryPicker(
            callBackFunction: _callBackFunction,
            headerText: 'Select Country',
            headerBackgroundColor: Theme.of(context).primaryColor,
            headerTextColor: Colors.white,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your Mobile',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(7),
              ),
              controller: _contactEditingController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sendOTP() {
    return ButtonTheme(
      height: 44,
      minWidth: 260,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color(0xFF246BFD),
        onPressed: () async {
          print('$_dialCode${_contactEditingController.text}');
          if (_contactEditingController.text.isEmpty) {
            showErrorDialog(context, 'Contact number can\'t be empty.');
          } else {
            final responseMessage = await Navigator.pushNamed(
                context, confirmOTP,
                arguments: '$_dialCode${_contactEditingController.text}');
            if (responseMessage != null) {
              showErrorDialog(context, responseMessage as String);
            }
          }
        },
        child: Text(
          'Send OTP',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _signUpwithEmail() {
    return SizedBox(
      height: 44,
      width: 250,
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color(0xFF246BFD),
        onPressed: () async {
          Navigator.pushNamed(context, registerRoute);
        },
        icon: Icon(
          Icons.mail_outline_outlined,
          color: Colors.white,
        ),
        label: Text(
          'Sign Up with Email',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _socialMediaHandles() {
    return SizedBox(
      height: 44,
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 44,
            width: 110,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              borderSide: BorderSide(color: Colors.black87),
              onPressed: () async {
                AuthService().signInWithGoogle().whenComplete(() {
                  Navigator.pushNamed(context, dashboard);
                });
              },
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 44,
            width: 110,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              borderSide: BorderSide(color: Colors.black87),
              onPressed: () async {
                AuthService().signInWithFacebook().whenComplete(() {
                  Navigator.pushNamed(context, dashboard);
                });
              },
              child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skipButton() {
    return ButtonTheme(
      height: 24.75,
      minWidth: 56,
      buttonColor: Color.fromRGBO(35, 34, 51, 1),
      child: RaisedButton(
        onPressed: () {
          Navigator.pushNamed(context, dashboard);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Text(
          'Skip',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
