import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageChange extends StatefulWidget {
  @override
  _ImageChangeState createState() => _ImageChangeState();
}

class _ImageChangeState extends State<ImageChange> {
  Color? _backgroundColor;
  File? _image;

  void _changeBackgroundColor() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _backgroundColor = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          _backgroundColor == null
              ? Container(
            decoration: BoxDecoration(
              image: _image != null
                  ? DecorationImage(
                image: FileImage(_image!),
                fit: BoxFit.cover,
              )
                  : DecorationImage(
                image: AssetImage('assets/default_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )
              : Container(color: _backgroundColor),
          Center(
            child: GestureDetector(
              onTap: _changeBackgroundColor,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black),
                  image: _image != null
                      ? DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _image == null
                    ? null
                    : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background_image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}