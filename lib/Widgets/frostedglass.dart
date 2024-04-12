import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class frostedglass_ extends StatelessWidget {



  const frostedglass_({super.key,required this.theheight,required this.thewidth, required this.theChild,required this.thecolor});

  final thewidth;
  final theheight;
  final theChild;
  final thecolor;




  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: thewidth,
        height: theheight,
        color: thecolor,

        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),

              child: Container(

              ),

            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05)
                  ],
                ),
              ),
            ),

            Center(child: theChild)
          ],
        ),
      ),
    );
  }
}
