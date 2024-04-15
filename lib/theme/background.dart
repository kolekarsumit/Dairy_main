import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class backscreen extends StatelessWidget {
  const backscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: getSelectedBackgroundStream(),
      builder: (context, snapshot) {
        String selectedImagePath = snapshot.data ?? "assets/images/background1.png";
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(selectedImagePath),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
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
