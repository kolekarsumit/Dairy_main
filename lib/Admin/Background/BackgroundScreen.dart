import 'package:dairy/theme/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class back extends StatefulWidget {
  const back({super.key});

  @override
  State<back> createState() => _backState();
}

class _backState extends State<back> {
  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(),
          GestureDetector(
            onTap: (){
              backscreen(str:"assets/images/background1.png");
            },
            child: Container(
              height: 250,
              width: 250,
              child: Image.asset("assets/images/background1.png"),
            ),
          ), Container(
            height: 250,
            width: 250,
            child: Image.asset("assets/images/background2.png"),
          ),Container(
            height: 250,
            width: 250,
            child: Image.asset("assets/images/background2.png"),
          ),Container(
            height: 250,
            width: 250,
            child: Image.asset("assets/images/background2.png"),
          ),
          SizedBox(),
        ],
      );
  }
}
