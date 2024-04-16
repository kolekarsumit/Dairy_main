import 'dart:io';
import 'package:flutter/material.dart';
import '../Admin/Admin_pannel/machine_model.dart';
import '../Admin/theme/colors.dart';

class topbar extends StatefulWidget {
  const topbar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<topbar> {
  late Future<String> _logo1Future;
  late Future<String> _logo2Future;

  @override
  void initState() {
    super.initState();
    _logo1Future = MachineInfo.getSelectedLogo('Logo1');
    _logo2Future = MachineInfo.getSelectedLogo('Logo2');
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
            child: FutureBuilder<String>(
              future: _logo1Future,
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
            child: FutureBuilder<String>(
              future: _logo2Future,
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
          ),
        ],
      ),
    );
  }
}
