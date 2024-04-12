import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class getknow_ extends StatelessWidget {
  const getknow_({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            shape: BoxShape.circle,
            color: Colors.transparent),
      ),
      
       Icon(CupertinoIcons.exclamationmark_octagon)
    ]);
  }
}
