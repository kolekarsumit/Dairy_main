import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dairy/Admin/Admin_pannel/navbar.dart';
import 'package:dairy/Admin/Background/BackgroundScreen.dart';
import 'package:dairy/main.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Screens/logoscreen.dart';
import '../../bluetooth_service/utils/toast_msg.dart';
import 'Payment.dart';
import 'ShowProduct.dart';
import 'details_model.dart';
import 'machine_model.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final double width;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    this.width = 40.0,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "${widget.label} :",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: widget.width),
        Flexible(
          child: TextFormField(
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.black45,
                fontSize: 18,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(width: 100),
      ],
    );
  }
}

class AdminView extends StatefulWidget {
  final Function(MachineInfo) callback;
  AdminView({required this.callback});

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  TextEditingController          nameController = TextEditingController();
  TextEditingController          mobileNoController=TextEditingController();
  TextEditingController          cityController=TextEditingController();
  TextEditingController          BTnameController=TextEditingController();
  TextEditingController          BTaddressController=TextEditingController();
  TextEditingController          merchandIdController=TextEditingController();



  @override
  void initState(){
    super.initState();
    loadMachineInfo();
  }
  MachineInfo machineInfo=MachineInfo(
      isPaymentMode:false,
      icon1: '',
      icon2: '',
      background: '',
      name: '',
      mobileNo: '',
      city: '',
      BTname: '',
      BTaddress: '',
      merchantId: '');

  void loadMachineInfo()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? machineinfojson=preferences.getString('machineInfo');
    print('Loading machininfo ${machineinfojson}');
    if(machineinfojson !=null){
       machineInfo = MachineInfo.fromJson(jsonDecode(machineinfojson));
       setState(() {
      });
       setDefaultDataToController(machineInfo);
    }
  }


  @override
  void dispose(){
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backscreen(
            machineInfo: machineInfo,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                nav_(
                  callback: (info){
                    machineInfo=info;
                    widget.callback(info);
                    print('admin page callback');
                    setState(() {
                    });
                  },
                  machineInfo: machineInfo,
                ),
                SizedBox(height: 30),
                CustomTextField(
                  label: "Name",
                  hintText: "Enter Name",
                  keyboardType: TextInputType.text,
                  width: 170.0,
                  controller: nameController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "Mobile Number",
                  hintText: "Enter Mobile number",
                  keyboardType: TextInputType.phone,
                  width: 60.0,
                  controller: mobileNoController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "City",
                  hintText: "Enter City",
                  keyboardType: TextInputType.text,
                  width: 190.0,
                  controller: cityController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "BT Name",
                  hintText: "Enter BT Name",
                  keyboardType: TextInputType.text,
                  width: 130.0,
                  controller: BTnameController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "BT Address",
                  hintText: "Enter BT Address",
                  keyboardType: TextInputType.text,
                  width: 100.0,
                  controller: BTaddressController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "Merchant ID",
                  hintText: "Enter Merchant ID",
                  keyboardType: TextInputType.text,
                  width: 90.0,
                  controller: merchandIdController,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // widget.callback(widget.machine);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        backgroundColor: Colors.blue[300], // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          saveMachineInfo();
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    // MachineInformation(),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: _printInput,
                //   child: Text("Print Input"),
                // ),

                SizedBox(height: 100,),
                Itemproduct(),

                SizedBox(height: 100),

                Text("Change Background",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                back(
                  callback: (info){
                    machineInfo=info;
                    widget.callback(info);
                    setState(() {
                    });
                  },
                  machineInfo: machineInfo,
                ),


                SizedBox(height: 100,),

                LogoSelector(
                 callback: (info){
                   machineInfo=info;
                   widget.callback(info);
                 },
                  machineInfo: machineInfo,
                ),

                SizedBox(height: 20,),

              ],
            ),
          ),
        ],
      ),
    );
  }


  MachineInfo getMachineInfo(){
    String nameStr=  nameController.text.toString();
    String  mobileStr=mobileNoController.text.toString();
    String  cityStr=  cityController.text.toString();
    String  BTnameStr= BTnameController.text.toString();
    String  BTaddressStr=BTaddressController.text.toString();
    String  merchandIdStr=merchandIdController.text.toString();
    MachineInfo machine=MachineInfo(
        isPaymentMode: machineInfo.isPaymentMode,
        name: nameStr,
        mobileNo: mobileStr,
        city: cityStr,
        BTname: BTnameStr,
        BTaddress: BTaddressStr,
        icon2: machineInfo.icon1,
        icon1: machineInfo.icon1,
        background: machineInfo.background,
        merchantId: merchandIdStr);
    return machine;
  }

  void saveMachineInfo()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     machineInfo=getMachineInfo();

    if(!blueServices.validateID(machineInfo.BTaddress)){
      toastMessage('Please Enter Valid BT Address');
      return;
    }
    String machineInfoJson = jsonEncode(machineInfo);
    print(machineInfoJson);
    prefs.setString('machineInfo', machineInfoJson);
    toastMessage('Saved Successfully !');
    widget.callback(machineInfo);
    print('admin page callback');
    setState(() {
    });
  }

  void setDefaultDataToController(MachineInfo machineInfo) {
    nameController.text=machineInfo.name;
    mobileNoController.text=machineInfo.mobileNo;
    cityController.text=machineInfo.city;
    BTnameController.text=machineInfo.BTname;
    BTaddressController.text=machineInfo.BTaddress;
    merchandIdController.text=machineInfo.merchantId;
  }
}