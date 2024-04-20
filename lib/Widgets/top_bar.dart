import 'dart:io';
import 'package:flutter/material.dart';
import '../Admin/Admin_pannel/machine_model.dart';
import '../theme/colors.dart';

class topbar extends StatefulWidget {
  MachineInfo machineInfo;
   topbar({required this.machineInfo}) ;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<topbar> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 350,
            height: 150,
            child: widget.machineInfo.icon1.isNotEmpty ? Container(
              width: 100.0, // Adjust width as needed
              height: 100.0, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(widget.machineInfo.icon1)),
                ),
              ),
            )
                : SizedBox(),
          ),

          Container(
            width: 5,
          ),
          Text(
            "THE FRESH DAIRY PRODUCT",
            style: TextStyle(
              fontFamily: 'bolt-semibold.ttf',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.primarygray,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 5),
          Container(
            width: 350,
            height: 150,
            child: widget.machineInfo.icon2.isNotEmpty ? Container(
              width: 100.0, // Adjust width as needed
              height: 100.0, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(widget.machineInfo.icon2)),
                ),
              ),
            )
                : SizedBox(),
          ),

        ],
      ),
    );
  }
}
