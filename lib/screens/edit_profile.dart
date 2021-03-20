import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/user.dart';
import '../Services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/button.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //Setup Stream Higher or a Wrapper around Home to avoid another Listener here
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // final TextEditingController _name = TextEditingController();
    // final TextEditingController _city = TextEditingController();
    // final TextEditingController _state = TextEditingController();

    String _name;
    String _city;
    String _state;

    //SET UP STREAM in a wrapper above Home =>

    // final profileData = Provider.of<UserData>(context);
    // print(profileData.phoneNumber);
    // print(profileData.email);
    // print(profileData.displayName);
    // print(profileData.city);
    // print(profileData.state);
    //
    //TODO:Styling->Remove this StreamBuilder. Stream is already present in parent settings page?
    //TODO:Image picker upload image
    final uID = _authService.getUID;
    print(uID);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: uID).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            UserData userData = snapshot.data;
            return Scaffold(
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Edit Your Profile',
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 26),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    AssetImage('assets/placeholder.PNG'),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'John Doe',
                                        labelText: 'Enter your name'),
                                    initialValue: userData.displayName,
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter a name'
                                        : null,
                                    onSaved: (value) {
                                      setState(() {
                                        _name = value;
                                      });
                                    },
                                    onChanged: (v) {
                                      _name = v;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Pune',
                                        labelText: 'Enter your City'),
                                    initialValue: userData.city,
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter a value'
                                        : null,
                                    onSaved: (value) {
                                      setState(() {
                                        _city = value;
                                      });
                                    },
                                    onChanged: (v) {
                                      _city = v;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Maharashtra',
                                        labelText: 'Enter your State'),
                                    initialValue: userData.state,
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter a value'
                                        : null,
                                    onSaved: (value) {
                                      setState(() {
                                        _state = value;
                                      });
                                    },
                                    onChanged: (v) {
                                      _state = v;
                                      print(_state);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black54,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          CupertinoStyleButton(
                              color: greenButton,
                              name: 'Update',
                              myFunction: () async {
                                if (_formKey.currentState.validate()) {
                                  print(_name);
                                  print(_city);
                                  print(_state);
                                  await DatabaseService(uid: uID).updateUser(
                                      _name ?? userData.displayName,
                                      _city ?? userData.city,
                                      _state ?? userData.state);
                                }
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
