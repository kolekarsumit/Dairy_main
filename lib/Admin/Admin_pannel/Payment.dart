import 'dart:convert';
import 'package:dairy/bluetooth_service/utils/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'machine_model.dart';

class PaymentContainer extends StatefulWidget {
  @override
  _PaymentContainerState createState() => _PaymentContainerState();
}

class _PaymentContainerState extends State<PaymentContainer> {
  bool isPaymentMode = true;
   MachineInfo machineInfo=MachineInfo(isPaymentMode: true, name: '', mobileNo: '', city: '', BTname: '', BTaddress: '', merchantId: '');
  @override
  void initState(){
    super.initState();
    loadMachineInfo();

  }
  Future<bool> loadMachineInfo()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? machineinfojson=preferences.getString('machineInfo');
    print('Loading machininfo ${machineinfojson}');
    if(machineinfojson !=null){
       machineInfo = MachineInfo.fromJson(jsonDecode(machineinfojson));
       isPaymentMode=machineInfo.isPaymentMode;
       setState(() {
       });
    }
    return true;
  }

  void toggleMode() async{
    await loadMachineInfo();

    setState(() {
      isPaymentMode = !isPaymentMode;
      saveMachineInfo();
    });
    String mode=isPaymentMode?'Payment Mode':'Free Mode';
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
          isPaymentMode ? "Payment Mode" : "Free Mode",
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
    machineInfo.isPaymentMode=isPaymentMode;
    String machineInfoJson = jsonEncode(machineInfo);
    print('updated info ${machineInfoJson}');
    prefs.setString('machineInfo', machineInfoJson);
  }
}