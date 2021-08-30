import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HelpImagePicker extends StatefulWidget {
  @override
  _HelpImagePickerState createState() => _HelpImagePickerState();
}

class _HelpImagePickerState extends State<HelpImagePicker> {
  File _pickedImage;
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(
      imageQuality: 50,
      maxWidth: 200,
    );
    final pickedImageFile = File(pickedImages[1].path);
    print(pickedImages[1].path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Color(0x98123456),
          backgroundImage: _pickedImage != null
              ? FileImage(
                  _pickedImage,
                )
              : null,
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton.icon(
          color: Theme.of(context).accentColor,
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
          ),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
