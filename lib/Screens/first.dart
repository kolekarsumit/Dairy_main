import 'dart:convert';

import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:dairy/Screens/second.dart';
import 'package:dairy/Widgets/top_bar.dart';
import 'package:dairy/cards/itemcard.dart';
import 'package:dairy/cards/nextBTN.dart';
import 'package:dairy/models/Textmodel.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../Admin/Admin_pannel/details_model.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Itemscreen extends StatefulWidget {
  MachineInfo machineInfo;
  Itemscreen( this.machineInfo, {Key? key}) : super(key: key);

  @override
  State<Itemscreen> createState() => _ItemscreenState();
}

class _ItemscreenState extends State<Itemscreen> {
  int selectedcardindex = -1;

  void selectedcard(int index) {
    setState(() {
      selectedcardindex = index;

    });
  }

  FlutterTts _flutterTts=FlutterTts();
  speak(String text) {
    _flutterTts.setLanguage("eu-US");
    _flutterTts.setPitch(1);
    _flutterTts.speak(text);
  }

  List<Product> productDetails = [];
  List<String> img=[
    "assets/images/cow.png",
    "assets/images/buffalo_.png",
    "assets/images/butterMilk_.png",
  ];
  @override
  void initState() {
    super.initState();
    print('first screen machineinfo modle ${widget.machineInfo.toJson()}');
    loadProductList();
    speak(first);

  }
  void loadProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productListJson = prefs.getString('productList');
    print(productListJson);
    if (productListJson != null) {
      List<dynamic> jsonList = jsonDecode(productListJson);
      setState(() {
        productDetails =
            jsonList.map((json) => Product.fromJson(json)).toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          backscreen(
            machineInfo: widget.machineInfo,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              topbar(machineInfo: widget.machineInfo,),
              SizedBox(height: 50,),
              Expanded(
                // Use Expanded directly here
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 4.0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(int index=0;index<productDetails.length;index++)
                          GestureDetector(
                            onTap: (){
                              selectedcardindex=index;
                              setState(() {});
                            },
                            child: Padding(
                                padding:EdgeInsets.all(8),
                                child: productDetails[index].isEnable?item_card(productDetails[index], img[index%3], selectedcardindex==index):Container()),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height:10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomBTN(selected: selectedcardindex==-1,isNextBtn: false),
                    ),
                  ),
                  SizedBox(width: 80,),
                  IgnorePointer(
                    ignoring: selectedcardindex==-1,
                    child: GestureDetector(
                      onTap: () {
                        if(selectedcardindex!=-1&&productDetails[selectedcardindex].stock!=0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => pricescreen(selectedcardindex,img[selectedcardindex%3],productDetails,widget.machineInfo),
                            ),
                          );
                        }else{
                          Fluttertoast.showToast(msg: "Please select a product before proceeding.\n If any product is out of stock, please remove it from your selection",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);

                        }

                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CustomBTN(selected: selectedcardindex != -1,isNextBtn: true),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }

}