import 'dart:io'; // Import 'dart:io' for File
import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class backscreen extends StatelessWidget {
  MachineInfo machineInfo;
   backscreen({required this.machineInfo});

  @override
  Widget build(BuildContext context) {
    return machineInfo.background.isNotEmpty ? _buildImage(machineInfo.background)
        : Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      color: Colors.white, // Default background color if no image is selected
    );

  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(imagePath)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }


}
