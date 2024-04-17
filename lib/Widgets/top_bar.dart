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
            child: widget.machineInfo.icon1.isNotEmpty? CircleAvatar(
              radius: 50.0,
              backgroundImage: FileImage(File(widget.machineInfo.icon1)),
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
            width: 220,
            height: 150,
            child: widget.machineInfo.icon2.isNotEmpty? CircleAvatar(
              radius: 50.0,
              backgroundImage: FileImage(File(widget.machineInfo.icon2)),
            )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
