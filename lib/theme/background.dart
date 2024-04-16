import 'dart:io'; // Import 'dart:io' for File
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class backscreen extends StatelessWidget {
  const backscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: getSelectedBackgroundStream(),
      builder: (context, snapshot) {
        String selectedImagePath = snapshot.data ?? "";
        if (selectedImagePath.isNotEmpty) {
          return _buildImage(selectedImagePath);
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white, // Default background color if no image is selected
          );
        }
      },
    );
  }

  // Function to build a container with FileImage
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

  // Stream to listen for changes in the selected background image path
  Stream<String> getSelectedBackgroundStream() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    while (true) {
      yield prefs.getString('selectedBackground') ?? "";
      await Future.delayed(Duration(seconds: 1)); // Adjust the delay as needed
    }
  }
}
