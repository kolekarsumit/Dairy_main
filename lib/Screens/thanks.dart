import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:dairy/Screens/front.dart';
import 'package:dairy/Widgets/top_bar.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

import '../models/Textmodel.dart';

class thanks_ extends StatefulWidget {
  MachineInfo machineInfo;
   thanks_({required this.machineInfo});
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
          MaterialPageRoute(builder: (context) => Front_(
          )),
        );
      });
    });
    speak(thanks);
  }
  FlutterTts _flutterTts=FlutterTts();
  speak(String text) {
    _flutterTts.setLanguage("eu-US");
    _flutterTts.setPitch(1);
    _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backscreen(
            machineInfo: widget.machineInfo,
          ),
          Column(
            children: [
              SizedBox(height: 10,),
              topbar(machineInfo: widget.machineInfo,),
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
