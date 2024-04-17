import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:dairy/Screens/front.dart';
import 'package:dairy/Screens/thanks.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class fourth_ extends StatefulWidget {
   MachineInfo machineInfo;
   fourth_({required this.machineInfo});

  @override
  State<fourth_> createState() => _fourthState();
}

class _fourthState extends State<fourth_> {

  void initState() {
    super.initState();
    // Wait for 10 seconds and then navigate to the second screen
    Future.delayed(Duration(seconds: 44), () {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => thanks_(
            machineInfo: widget.machineInfo,
          )),
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          backscreen(
            machineInfo: widget.machineInfo,
          ),
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
