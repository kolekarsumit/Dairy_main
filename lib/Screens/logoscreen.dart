import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bluetooth_service/utils/toast_msg.dart';

class LogoSelector extends StatefulWidget {
  @override


  Function(MachineInfo) callback;
  MachineInfo machineInfo;
   LogoSelector({
    required this.machineInfo,
    required this.callback
  });
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
          widget.machineInfo.icon1=_image1!.path;
          // Save selected logo path with key 'Logo1'
        } else {
          _image2 = File(pickedFile.path);
          widget.machineInfo.icon2=_image2!.path;
        }
        saveMachineInfo(widget.machineInfo);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _getImage(1),
                  child: Text('Select Logo 1'),
                ),
                SizedBox(height: 50,),
               widget.machineInfo.icon1.isNotEmpty? CircleAvatar(
                  radius: 50.0,
                  backgroundImage: FileImage(File(widget.machineInfo.icon1)),
                ):CircleAvatar(
                 radius: 50.0,
                 backgroundColor: Colors.black12,
               )
              ],
            ),

            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _getImage(2),
                  child: Text('Select Logo 2'),
                ),

                SizedBox(height: 50,),
                widget.machineInfo.icon2.isNotEmpty? CircleAvatar(
                  radius: 50.0,
                  backgroundImage: FileImage(File(widget.machineInfo.icon2)),
                ):CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.black12,
                )
              ],
            ),
          ],
        );

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
