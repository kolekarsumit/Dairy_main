import 'dart:convert';

import 'package:dairy/Screens/Datamodel.dart';
import 'package:dairy/Screens/thanks.dart';
import 'package:dairy/Widgets/top_bar.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Admin/Admin_pannel/machine_model.dart';
import '../bluetooth_service/services/blue_services.dart';
import '../main.dart';
import 'animation.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
   bool Paymentmode=true;

  void loadMachineInfo() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? machineinfojson=preferences.getString('machineInfo');
    print('Loading machininfo ${machineinfojson}');
    if(machineinfojson !=null){
      MachineInfo machineInfo = MachineInfo.fromJson(jsonDecode(machineinfojson));
      Paymentmode=machineInfo.isPaymentMode;
      // free mode
      if(!Paymentmode){

        // print(model.characters);

        String modelstr = model.characters.toString();
        modelstr = modelstr.replaceAll("[", "{");
        modelstr = modelstr.replaceAll("]", "}");

        print(modelstr);
        blueServices.sendDataOverSingleBluetooth(modelstr);

        model.characters = List<String>.generate(model.characters.length, (index) => '0');
        Future.delayed(Duration(seconds: 10), () {
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => anim()),
            );
          });
        });
      }

      else{

        //check payment success


      }

      setState(() {
    });
    }
  }
  // BlueServices blueServices=BlueServices();
  void initState() {
    super.initState();
    loadMachineInfo();

    // Wait for 10 seconds and then navigate to the second screen
    print(model.characters);
    print(Paymentmode);




  }

  @override
  Widget build(BuildContext context) {
  int time =12;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          backscreen(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10,),
              topbar(),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Milk Despensor LTD",style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'bolt-regular.ttf'
                  ),),
                  SizedBox(height: 5,),
                  Text("\$80.0",style: TextStyle(fontSize: 30,
                      fontFamily: 'bolt-regular.ttf',
                ),),
                  SizedBox(height: 5,),
                  Text("Payment Referance",style: TextStyle(
                    fontSize: 15, fontFamily: 'bolt-regular.ttf'
                  ),),
                  SizedBox(height: 35,),

                  Container(
                    width: 250,
                    height: 250,
                    child: Image.asset("assets/images/qr.jpg"),
                  ),
                  SizedBox(height: 20,),
                  Text("Remaing Time : ${time}",style: TextStyle(
                    fontSize: 15, fontFamily: 'bolt-regular.ttf'
                  ),),
                  SizedBox(height: 10,),
                  Text("Status : Waiting",style: TextStyle(
                    fontSize: 15,
                      fontFamily: 'bolt-regular.ttf'
                  ),)
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}


