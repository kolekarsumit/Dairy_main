import 'dart:convert';
import 'dart:io'; // Import 'dart:io' for File
import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../bluetooth_service/utils/toast_msg.dart';

class back extends StatefulWidget {
  MachineInfo machineInfo;
  Function(MachineInfo) callback;
   back({required this.machineInfo,required this.callback}) ;

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
    widget.machineInfo.background=imagePath;
    saveMachineInfo(widget.machineInfo);
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
  void saveMachineInfo(MachineInfo info)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String machineInfoJson = jsonEncode(info);
    print(machineInfoJson);
    prefs.setString('machineInfo', machineInfoJson);
    widget.callback(widget.machineInfo);
    toastMessage('Saved Successfully !');

  }
}
