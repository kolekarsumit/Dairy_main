import 'package:flutter/material.dart';

import 'Payment.dart';

class nav_ extends StatelessWidget {
  const nav_({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PaymentContainer(),
            SizedBox(),
            Text("SET UP YOUR MACHINE",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(),
            Image.asset("assets/images/logo.png",
              height: 120,width: 120,)
          ],
        ),
      ),
    );
  }
}
