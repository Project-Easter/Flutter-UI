import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Services/databaseService.dart';
import 'package:books_app/Widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/user.dart';
import '../Services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //Form Controllers

  // final TextEditingController _name = TextEditingController();
  // final TextEditingController _city = TextEditingController();
  // final TextEditingController _state = TextEditingController();
  //Setup Stream Higher or a Wrapper around Home to avoid another Listener here
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  //Firetorage Instance
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  //Image Picker
  final _imagePicker = ImagePicker();
  PickedFile image;

  //Pick Image Functions:

  //Image via Gallery
  Future<String> uploadImageGallery(String uID) async {
    //Select Image
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    var file = File(image.path);
    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await _firebaseStorage.ref().child("images/${uID}").putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
  }

  //Image via Camera
  Future<String> uploadImageCamera(String uID) async {
    //Select Image
    image = await _imagePicker.getImage(source: ImageSource.camera);
    var file = File(image.path);
    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await _firebaseStorage.ref().child("images/${uID}").putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return null;
  }

  String _name;
  String _city;
  String _state;
  String _imageUrl = "";
  @override
  Widget build(BuildContext context) {
    final uID = _authService.getUID;
    //SET UP STREAM in a wrapper above Home =>
    //TODO:Styling->Remove this StreamBuilder. Stream is already present in parent settings page and Home page?
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: uID).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                              // color: Colors.yellow,
                              height: 300,
                              width: 300,
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: _imageUrl == ""
                                    ? NetworkImage(userData.photoURL)
                                    : NetworkImage(_imageUrl),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.photo_camera, size: 30),
                                    onPressed: () async {
                                      String imageFromFirebase =
                                          await uploadImageCamera(uID);
                                      setState(() {
                                        _imageUrl = imageFromFirebase;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.photo_library, size: 30),
                                    onPressed: () async {
                                      String imageFromFirebase =
                                          await uploadImageGallery(uID);
                                      setState(() {
                                        _imageUrl = imageFromFirebase;
                                      });
                                    },
                                  ),
                                ],
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
                                if (_imageUrl == "") {
                                  print(userData.photoURL);
                                } else {
                                  print(_imageUrl);
                                }
                                await DatabaseService(uid: uID).updateUser(
                                    _name ?? userData.displayName,
                                    _city ?? userData.city,
                                    _state ?? userData.state,
                                    _imageUrl == ""
                                        ? userData.photoURL
                                        : _imageUrl);
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
