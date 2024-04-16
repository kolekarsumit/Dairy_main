import 'package:dairy/Screens/front.dart';
import 'package:dairy/Widgets/top_bar.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class thanks_ extends StatefulWidget {
  const thanks_({super.key});
  @override
  State<thanks_> createState() => _thanks_State();
}

class _thanks_State extends State<thanks_> {
  void initState() {
    super.initState();
    // Wait for 10 seconds and then navigate to the second screen
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Front_()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backscreen(),
          Column(
            children: [
              SizedBox(height: 10,),
              topbar(),
              SizedBox(height: 30,),
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/thanks.png"),
                    fit: BoxFit.fill
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Text("Sip, smile, repeat!",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'bolt-semibold.ttf'
              ),
              ),
              Text(" Cheers to your milk satisfaction!",style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'bolt-semibold.ttf',
                  fontWeight: FontWeight.bold,
              ),),
              Lottie.asset(
                  'animations/cowanimation.json',
                  height: 150,
                  reverse: true,
                  repeat: true,
                  fit: BoxFit.cover
              ),

            ],
          )
        ],
      ),
    );
  }
}
