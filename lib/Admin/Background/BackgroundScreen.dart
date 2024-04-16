import 'dart:io'; // Import 'dart:io' for File
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class back extends StatefulWidget {
  const back({Key? key}) : super(key: key);

  @override
  State<back> createState() => _BackState();
}

class _BackState extends State<back> {
  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            _selectImageFromGallery();
          },
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.grey, // Placeholder color
              image: _selectedImagePath != null
                  ? DecorationImage(
                image: FileImage(File(_selectedImagePath!)), // Use FileImage with the file path
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: _selectedImagePath == null
                ? Center(child: Icon(Icons.photo_library)) // Placeholder icon
                : null,
          ),
        ),
      ],
    );
  }

  // Function to update shared preferences with selected image path
  void selectBackground(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedBackground', imagePath);
    setState(() {
      _selectedImagePath = imagePath;
    }); // Trigger rebuild to reflect changes in backscreen
  }

  void _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectBackground(pickedFile.path);
    }
  }
}
