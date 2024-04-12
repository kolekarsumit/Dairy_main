import 'package:dairy/Screens/front.dart';
import 'package:dairy/Screens/thanks.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class anim extends StatefulWidget {
  const anim({super.key});

  @override
  State<anim> createState() => _animState();
}

class _animState extends State<anim> {

  void initState() {
    super.initState();
    // Wait for 10 seconds and then navigate to the second screen
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => thanks_()),
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            child: Lottie.asset(
                'animations/wating.json',
                height: 100,
                reverse: true,
                repeat: true,
                fit: BoxFit.cover
            ),
          ),
        ],
      ),


    );
  }
}
