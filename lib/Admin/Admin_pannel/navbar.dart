import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'Payment.dart';

class nav_ extends StatelessWidget {
  const nav_({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: MachineInfo.getSelectedLogo('Logo1'), // Retrieve selected logo path
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while fetching logo
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final selectedLogoPath = snapshot.data ?? "";
            return Container(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PaymentContainer(),
                    SizedBox(),
                    Text(
                      "SET UP YOUR MACHINE",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(),
                    // Display selected logo if available, otherwise display default logo
                    selectedLogoPath.isNotEmpty
                        ? CircleAvatar(
                      radius: 30.0,
                      backgroundImage: FileImage(File(selectedLogoPath)),
                    )
                        : Image.asset(
                      "assets/images/logo.png",
                      height: 120,
                      width: 120,
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
