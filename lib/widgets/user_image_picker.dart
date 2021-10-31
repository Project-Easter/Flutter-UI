import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
          radius: 35,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Add image')),
      ],
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // ignore: deprecated_member_use
    final PickedFile pickedImage = await (picker.getImage(
        source: ImageSource.camera) as Future<PickedFile>);
    final File pickedImageFile = File(pickedImage.path);
    setState(() {
      _imageFile = pickedImageFile;
    });
  }
}
