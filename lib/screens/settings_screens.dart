import 'package:books_app/common/themes.dart';
import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/theme.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/auth.dart';
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

class UserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService _authService = FirebaseAuthService();
    final String uID = _authService.getUID;
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: uID).userData,
      builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.hasData) {
          return Container(
              padding:
                  const EdgeInsets.only(top: 12, left: 0, right: 0, bottom: 10),
              child: Row(children: <Widget>[
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/images/Explr Logo.png'),
                  //  backgroundImage: NetworkImage(user.avatar,),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 9.0, top: 4.0),
                  child: Text(
                    snapshot.data.displayName,
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
        } else {
          return Text(
            'Connectivity Issue',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 19),
          );
        }
      },
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _currentSlidervalue = 10.0;
  double sliderValue = 10.0;
  bool _darkTheme = false;
  bool _switchValue = true;

  final String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam in odio condimentum, pellentesque ex at, condimentum nisi. Aliquam erat volutpat, proin nisl tellus.';
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);

    _darkTheme = themeNotifier.getTheme() == darkTheme;

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('Settings',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 30)),
                  ),
                  UserTile(),
                ])),
        body: ListView(
          padding: const EdgeInsets.only(right: 5, left: 5, bottom: 5),
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              title: Text(
                'Account Settings',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 15, right: 0),
              title: Text(
                'Edit Profile',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 18),
              ),
              trailing: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.EDIT_PROFILE),

                // icon: Icons.arrow_forward_ios,
                // size: 14,
              ),
            ),
            // ListTile(
            //   contentPadding: const EdgeInsets.only(left: 15, right: 0),
            //   title: Text(
            //     'Set Location Range',
            //     style: GoogleFonts.poppins(
            //         fontWeight: FontWeight.w400, fontSize: 18),
            //   ),
            //   trailing: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     child: Text(_currentSlidervalue.toStringAsFixed(2),
            //         style: GoogleFonts.poppins()),
            //   ),
            // ),
            // Slider(
            //   label: _currentSlidervalue.round().toString(),
            //   value: _currentSlidervalue,
            //   min: 0,
            //   max: 50,
            //   onChanged: (double value) {
            //     setState(() {
            //       _currentSlidervalue = value;
            //     });
            //     sliderValue = value;
            //   },
            // ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 15, right: 0),
              title: Text(
                'Push notifications',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 18),
              ),
              trailing: Transform.scale(
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
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 15, right: 0),
              title: Text(
                'Dark Mode',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 18),
              ),
              trailing: Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: Colors.black,
                  value: _darkTheme,
                  onChanged: (bool val) {
                    setState(() {
                      _darkTheme = val;
                    });
                    onThemeChanged(val, themeNotifier);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: PreferredSize(
                  child: Container(
                    color: silverDivisor,
                    height: 1.0,
                  ),
                  preferredSize: const Size.fromHeight(1.0)),
            ),

            ListTile(
              title: Text(
                'More',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            ExpansionTile(
              childrenPadding: const EdgeInsets.only(right: 15, left: 15),
              title: Text(
                'About us',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Theme.of(context).colorScheme.primary,
              ),
              children: <Widget>[Text(text)],
            ),
            ExpansionTile(
              childrenPadding: const EdgeInsets.only(right: 15, left: 15),
              title: Text(
                'Privacy Policy',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  size: 14, color: Theme.of(context).colorScheme.primary),
              children: <Widget>[Text(text)],
              // icon: Icons.arrow_forward_ios,
              // size: 14,
            ),
            ExpansionTile(
              childrenPadding: const EdgeInsets.only(right: 15, left: 15),
              title: Text(
                'Terms and Conditions',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  size: 14, color: Theme.of(context).colorScheme.primary),
              children: <Widget>[Text(text)],
            ),
            // _accountSettingsDetails(themeNotifier),
            // _moreWidget()
          ]).toList(),
        ));
  }

  Future<void> onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    value
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
