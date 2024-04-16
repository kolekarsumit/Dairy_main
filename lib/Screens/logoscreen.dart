import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoSelector extends StatefulWidget {
  @override

  final File? initialLogo1;
  final File? initialLogo2;
  final Function(File?, File?) onLogoSelection;

  const LogoSelector({
    Key? key,
    this.initialLogo1,
    this.initialLogo2,
    required this.onLogoSelection,
  }): super(key: key);
  _LogoSelectorState createState() => _LogoSelectorState();
}

class _LogoSelectorState extends State<LogoSelector> {
  File? _image1;
  File? _image2;

  final ImagePicker _picker = ImagePicker();

  // Inside _LogoSelectorState class
  Future<void> _getImage(int buttonIndex) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (buttonIndex == 1) {
          _image1 = File(pickedFile.path);
          MachineInfo.saveSelectedLogo(pickedFile.path, 'Logo1'); // Save selected logo path with key 'Logo1'
        } else {
          _image2 = File(pickedFile.path);
          MachineInfo.saveSelectedLogo(pickedFile.path, 'Logo2'); // Save selected logo path with key 'Logo2'
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _getImage(1),
              child: Text('Select Logo 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _getImage(2),
              child: Text('Select Logo 2'),
            ),
            SizedBox(height: 20),
            FutureBuilder<String>(
              future: MachineInfo.getSelectedLogo('Logo1'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  final logoPath = snapshot.data;
                  return logoPath != null
                      ? CircleAvatar(
                    radius: 50.0,
                    backgroundImage: FileImage(File(logoPath)),
                  )
                      : SizedBox(); // Placeholder or default logo widget
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<String>(
              future: MachineInfo.getSelectedLogo('Logo2'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  final logoPath = snapshot.data;
                  return logoPath != null
                      ? CircleAvatar(
                    radius: 50.0,
                    backgroundImage: FileImage(File(logoPath)),
                  )
                      : SizedBox(); // Placeholder or default logo widget
                }
              },
            ),
          ],
        );

  }
  void _passLogoInformation() {
    widget.onLogoSelection(_image1, _image2);
  }
}
