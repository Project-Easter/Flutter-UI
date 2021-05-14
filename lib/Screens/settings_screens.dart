import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Models/user.dart';
import 'package:books_app/Utils/theme_notifier.dart';
import 'package:books_app/Utils/values/theme_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/Auth.dart';
import '../Services/databaseService.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _darkTheme = true;
  bool _switchValue = true;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    final uID = _authService.getUID;
    print(uID);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: uID).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Setting Page");
            print(snapshot.data.photoURL);
            UserData userData = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                  toolbarHeight: 90,
                  bottom: PreferredSize(
                      child: Container(
                        color: silverDivisor,
                        height: 1.0,
                      ),
                      preferredSize: Size.fromHeight(1.0)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ClipRRect(
                      //     borderRadius: BorderRadius.circular(50.0),
                      //     child: Image.network(userData.photoURL,
                      //         height: 60, fit: BoxFit.fill)),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(userData.photoURL),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userData.displayName,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [_accountSettingsDetails(themeNotifier), _moreWidget()],
                  ),
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _accountSettingsDetails(tNotifier) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account Settings",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, editProfile);
            },
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Change password",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Change User Preferences",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Icon(
                  Icons.add,
                  size: 18,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Push notifications",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    activeColor: Colors.black,
                    value: _switchValue,
                    onChanged: (val) {
                      setState(() {
                        _switchValue = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Dark mode",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: Colors.black,
                  value: _darkTheme,
                  onChanged: (val) {
                    setState(() {
                      _darkTheme = val;
                    });
                    onThemeChanged(val, tNotifier);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _moreWidget() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "More",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "About us",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Privacy policy",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Terms and conditions",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  // Widget dayNightWidget(themeNotifier) {
  //   return ListView(
  //     children: <Widget>[
  //       ListTile(
  //         title: Text('Dark Theme'),
  //         contentPadding: const EdgeInsets.only(left: 16.0),
  //         trailing: Transform.scale(
  //           scale: 0.4,
  //           child: DayNightSwitch(
  //             value: _darkTheme,
  //             onChanged: (val) {
  //               setState(() {
  //                 _darkTheme = val;
  //               });
  //               onThemeChanged(val, themeNotifier);
  //             },
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value) ? themeNotifier.setTheme(darkTheme) : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
