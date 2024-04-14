import 'dart:convert';

import 'package:dairy/Screens/second.dart';
import 'package:dairy/Widgets/top_bar.dart';
import 'package:dairy/cards/itemcard.dart';
import 'package:dairy/cards/nextBTN.dart';
import 'package:dairy/theme/background.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Admin/Admin_pannel/details_model.dart';
import 'Datamodel.dart';
class Itemscreen extends StatefulWidget {
  const Itemscreen({Key? key}) : super(key: key);

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

  List<Product> productDetails = [];
  List<String> img=[
    "assets/images/cow.png",
    "assets/images/buffalo_.png",
    "assets/images/butterMilk_.png",
  ];
  @override
  void initState() {
    super.initState();
    loadProductList();

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
          backscreen(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              topbar(),
              SizedBox(height: 80,),
              Expanded(
                // Use Expanded directly here
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productDetails.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        selectedcardindex=index;
                        setState(() {});
                      },
                      child: Padding(
                          padding:EdgeInsets.all(12),
                          child: productDetails[index].isEnable?item_card(productDetails[index], img[index%3], selectedcardindex==index):Container()),
                    );
                  },
                ),
              ),
              SizedBox(height:20),
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
                        if(selectedcardindex!=-1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => pricescreen(selectedcardindex,img[selectedcardindex%3],productDetails),
                          ),
                          );
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

              SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }

}
