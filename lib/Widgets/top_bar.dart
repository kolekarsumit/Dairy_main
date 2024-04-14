import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class topbar extends StatelessWidget {
  const topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: 350,
                height: 150,
                child: Image.asset(

                  'assets/images/toplogo.png',
                  fit: BoxFit.fill,
                )
            ),
            Container(width: 5,),
            Text(
              "THE FRESH DAIRY PRODUCT",
              style: TextStyle(
                  fontFamily: 'bolt-semibold.ttf',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primarygray,
                  decoration: TextDecoration.none
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 5,),
            Container(
                width: 220,
                height: 150,
                child: Image.asset(
                  'assets/images/logo2.png',
                  fit: BoxFit.cover,
                )
            ),
          ],
              ),

    );
  }
}
