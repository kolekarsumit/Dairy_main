import 'dart:convert';
import 'package:dairy/bluetooth_service/utils/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'machine_model.dart';

class PaymentContainer extends StatefulWidget {
  MachineInfo machineInfo;
  Function(MachineInfo) callback;
  PaymentContainer({required this.machineInfo,required this.callback});

  @override
  _PaymentContainerState createState() => _PaymentContainerState();
}

class _PaymentContainerState extends State<PaymentContainer> {
  @override
  void initState(){
    super.initState();

  }

  void toggleMode() async{

    setState(() {
      widget.machineInfo.isPaymentMode=!widget.machineInfo.isPaymentMode;
      saveMachineInfo();
    });
    String mode=widget.machineInfo.isPaymentMode?'Payment Mode':'Free Mode';
    toastMessage('Switching to ${mode}');

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleMode();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.yellowAccent,
          border: Border.all(color: Colors.black54, width: 1),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Text(
          widget.machineInfo.isPaymentMode ?"Payment Mode":"Free Mode",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  void saveMachineInfo()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String machineInfoJson = jsonEncode(widget.machineInfo);
    print('updated info ${machineInfoJson}');
    prefs.setString('machineInfo', machineInfoJson);
    widget.callback(widget.machineInfo);

  }
}