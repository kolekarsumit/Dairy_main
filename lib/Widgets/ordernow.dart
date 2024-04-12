import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../theme/colors.dart';

class ordernow_ extends StatelessWidget {
  const ordernow_({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("ORDER",style: TextStyle(
            fontFamily: 'StyleScript-Regular.ttf' ,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.white
        ),),
        Text("NOW",style: TextStyle(
            fontFamily: 'StyleScript-Regular.ttf' ,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.white
        ),)
      ],
    );
  }
}
