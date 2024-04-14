import 'package:dairy/Screens/thanks.dart';
import 'package:dairy/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class backscreen extends StatelessWidget {
  final String? str;
  const backscreen({super.key,this.str});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color:AppColor.primarybordercol,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          str!.isEmpty?"assets/images/background2.png":str!,
          fit: BoxFit.cover,
        )
    );
  }
}
