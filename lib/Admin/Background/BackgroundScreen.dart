// back.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/theme/background.dart';

class back extends StatefulWidget {
  const back({Key? key}) : super(key: key);

  @override
  State<back> createState() => _BackState();
}

class _BackState extends State<back> {
  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          GestureDetector(
            onTap: () {
              selectBackground("assets/images/background2.png");
            },
            child: Container(
              height: 250,
              width: 250,
              child: Image.asset("assets/images/background2.png"),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectBackground("assets/images/background1.png");
            },
            child: Container(
              height: 250,
              width: 250,
              child: Image.asset("assets/images/background1.png"),
            ),
          ),
          // Add more GestureDetector widgets for other options if needed
          SizedBox(),
        ],

    );
  }

  // Function to update shared preferences with selected image path
  void selectBackground(String imagePath) async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    await prefs.setString('selectedBackground', imagePath);
    setState(() {}); // Trigger rebuild to reflect changes in backscreen
  }
}
