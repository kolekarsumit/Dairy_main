import 'dart:convert';

import 'package:dairy/Admin/Admin_pannel/Admin_View.dart';
import 'package:dairy/Screens/first.dart';
import 'package:dairy/Screens/password.dart';
import 'package:dairy/bluetooth_service/services/blue_services.dart';
import 'package:dairy/theme/background.dart';
import 'package:dairy/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Admin/Admin_pannel/machine_model.dart';
import '../Widgets/frostedglass.dart';
import '../Widgets/ordernow.dart';
import '../Widgets/top_bar.dart';
import '../main.dart';

class Front_ extends StatefulWidget {
  const Front_({super.key});

  @override
  State<Front_> createState() => _Front_State();
}

class _Front_State extends State<Front_> with TickerProviderStateMixin {

  late AnimationController _controller;
  String status = "Connecting";
  bool btConnected = false;


  @override
  void initState() {
    super.initState();
    loadMachineInfo();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
      _controller.repeat(reverse: true);
  }




  Future<bool> loadMachineInfo()async{
    status='Connecting';
    btConnected=false;
    setState(() {
    });
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? machineinfojson=preferences.getString('machineInfo');
    print('Loading machininfo ${machineinfojson}');
    if(machineinfojson !=null){
      MachineInfo machineInfo = MachineInfo.fromJson(jsonDecode(machineinfojson));
      print(machineInfo.BTaddress);
      if(machineInfo.BTaddress.isNotEmpty && blueServices.validateID(machineInfo.BTaddress)){
        bool isConnected =await blueServices.triggerPipelineToConnect(machineInfo.BTaddress);
        if(isConnected){
          status='Connected';
          btConnected=true;
        }else{
          status='Not Connected';
        }

      }else{

        status='Address Not Found';

      }

    setState(() {

    });

    }
return true;
  }

  @override
  void didUpdateWidget(covariant Front_ oldWidget) {
    super.didUpdateWidget(oldWidget);
      _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int tapcount=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backscreen(),
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            topbar(),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: ()async{
                         await loadMachineInfo();

                        },
                        child:  Container(
                          child: Icon(
                            btConnected
                                ? Icons.bluetooth_connected
                                : Icons.bluetooth_disabled,
                            size: 50,
                            color: btConnected ? AppColor.primarygray : AppColor.primarybordercol,
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text(
                        status,
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'bolt-semibold.ttf',
                        color: AppColor.primarygray,
                        decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      tapcount++;
                      print(tapcount);
                      if(tapcount==5){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PinCodeWidget()),);
                        tapcount =0;
                      }
                    });
                  },

                  child: frostedglass_(
                      theheight: 100.0,
                      thewidth: 650.0,
                      theChild: Text(
                       "name",
                        style: TextStyle(
                            fontFamily: 'bolt-semibold.ttf',
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            fontSize: 55,
                            color: Colors.white),
                      ),
                      thecolor: Colors.transparent),
                ),
                SizedBox(),

              ],
            ),
            SizedBox(
              height: 50,
            ),
            ShaderMask(
              shaderCallback: (bounds) {
                return AppColor.gradient3.createShader(
                    Rect.fromLTRB(0, 0, bounds.width, bounds.height));
              },
              child: Text(
                "Farm-fresh goodness,",
                style: TextStyle(
                    fontFamily: 'bolt-regular.ttf',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return AppColor.gradient3.createShader(
                      Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                child: Text(
                  "dispensed just for you!",
                  style: TextStyle(
                      fontFamily: 'bolt-regular.ttf',
                      fontSize: 25,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),


            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + _controller.value * 0.2,
                  child: Container(

                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: AppColor.yellow,
                    ),
                    width: 180,
                    height: 120,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Itemscreen()),
                        );
                      },

                      child:  ordernow_(),

                    ),
                  ),
                );
              },
            ),

            // SizedBox(height: 50,)
          ],
        )
      ],
    );
  }
}
