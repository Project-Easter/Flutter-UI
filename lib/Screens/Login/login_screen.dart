import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/painting.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget _enterMobileNo() {
    return Container(
      alignment: Alignment.center,
      height: 44,
      width: 250,
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
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.mobile_friendly_rounded,
          ),
          hintText: 'Enter Mobile No',
        ),
      ),
    );
  }

  Widget _sendOTP() {
    return ButtonTheme(
      height: 44,
      minWidth: 250,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color(0xFF246BFD),
        onPressed: () {},
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
        onPressed: () {},
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
              borderSide: BorderSide(color: Colors.white),
              onPressed: () {},
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
              borderSide: BorderSide(color: Colors.white),
              onPressed: () {},
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
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Text(
          'Skip',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login'),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1529148482759-b35b25c5f217?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OXx8bGlicmFyeXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Color.fromRGBO(25, 24, 45, 0.75),
            child: Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _skipButton(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Image.asset('assets/Barter Books logo.png'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Welcome to',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Barter Books',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
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
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'with others',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          ' or you can ',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 1,
                          width: 120,
                          color: Colors.white,
                        ),
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
}
