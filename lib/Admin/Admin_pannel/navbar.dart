import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'Payment.dart';

class nav_ extends StatelessWidget {
  Function(MachineInfo) callback;
  MachineInfo machineInfo;
   nav_({required this.callback,required this.machineInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PaymentContainer(
              callback: (info){
                machineInfo=info;
                callback(info);
              },
              machineInfo:machineInfo,
            ),
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
            machineInfo.icon1.isNotEmpty
                ? CircleAvatar(
              radius: 30.0,
              backgroundImage: FileImage(File( machineInfo.icon1)),
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
