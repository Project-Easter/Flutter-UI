import 'package:books_app/Constants/colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/Utils/theme_notifier.dart';
import 'package:books_app/common/themes.dart';
import 'package:books_app/models/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkTheme = false;
  bool _switchValue = true;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = themeNotifier.getTheme() == darkTheme;
    final dynamic uID = _authService.getUID;
    print(uID);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: uID as String).userData,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasData) {
            print('Setting Page');
            print(snapshot.data.photoURL);
            final UserData userData = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    automaticallyImplyLeading: false,
                    elevation: 0.0,
                    toolbarHeight: 150,
                    bottom: PreferredSize(
                        child: Container(
                          color: silverDivisor,
                          height: 1.0,
                        ),
                        preferredSize: const Size.fromHeight(1.0)),
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Settings',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 45)),
                          _profile(uID, userData),
                        ])),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _accountSettingsDetails(themeNotifier),
                      _moreWidget()
                    ],
                  ),
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<void> onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    value
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  Widget _profile(dynamic uID, UserData userData) {
    return Container(
        padding: const EdgeInsets.only(top: 12, left: 0, right: 0, bottom: 10),
        child: Row(children: <Widget>[
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(userData.photoURL),
          ),
          Container(
            padding: const EdgeInsets.only(left: 9.0, top: 4.0),
            child: Text(
              userData.displayName,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 19),
            ),
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.EDIT_PROFILE);
              },
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ))
        ]));
  }

  Widget _accountSettingsDetails(ThemeNotifier tNotifier) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Account Settings',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.EDIT_PROFILE);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Change password',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Change User Preferences',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              const Icon(
                Icons.add,
                size: 18,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Push notifications',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: Colors.black,
                  value: _switchValue,
                  onChanged: (bool val) {
                    setState(() {
                      _switchValue = val;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Dark mode',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: Colors.black,
                  value: _darkTheme,
                  onChanged: (bool val) {
                    setState(() {
                      _darkTheme = val;
                    });
                    onThemeChanged(val, tNotifier);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _moreWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'More',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.ABOUT_US);
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'About us',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.PRIVACY_POLICY);
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Privacy policy',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.TERMS_CONDITION);
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Terms and conditions',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
