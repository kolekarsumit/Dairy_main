import 'dart:convert';

import 'package:dairy/Admin/Admin_pannel/details_model.dart';
import 'package:dairy/Screens/Datamodel.dart';
import 'package:dairy/Screens/thanks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dairy/Screens/third.dart';
import 'package:dairy/Widgets/top_bar.dart';
import 'package:dairy/cards/itemcard.dart';
import 'package:dairy/cards/nextBTN.dart';
import 'package:dairy/cards/price_card.dart';
import 'package:dairy/theme/background.dart';
import 'package:dairy/theme/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pricescreen extends StatefulWidget {

  int selectedindex;
  String img;


   pricescreen(this.selectedindex,  this.img);

  @override
  State<pricescreen> createState() => _pricescreenState();
}



class _pricescreenState extends State<pricescreen> {
  int cardindex = -1;
  int _selectedcardindex=-1;
  String product='';
  int total=-1;
  int pp=0;
  // int current=0;

  @override
  // void initState() {
  //   if(widget.product==0){
  //     img='assets/images/cow.png';
  //     product='Cow Milk';
  //     pp=25;
  //   }else if(widget.product==1){
  //     img='assets/images/buffalo_.png';
  //     product='Buffalo Milk';
  //     pp=33;
  //   }
  //   else{
  //     img='assets/images/butterMilk_.png';
  //     product='Butter Milk';
  //     pp=40;
  //   }
  // }

  void selectedcard(int index) {
    setState(() {
      _selectedcardindex = index;
      if(_selectedcardindex==0){
        total=pp*1;
      }else if(_selectedcardindex==1){
        total=pp*2;
      }
      else{
        total=pp*4;
      }

    });
  }

  @override
  void initState() {
    super.initState();
    loadProductList();
    cardindex=widget.selectedindex;
    print("selected index is : ${cardindex}");

  }
  List<Product> productDetails = [];
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

    String _img=widget.img;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          backscreen(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20,),
              topbar(),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(onTap: () => selectedcard(0),
                      child: price(_img, productDetails[cardindex].quantity1 , _selectedcardindex == 0,pp*1),
                    ),
                    GestureDetector(onTap: () => selectedcard(1),
                      child: price(_img,  productDetails[cardindex].quantity2 , _selectedcardindex == 1,pp*2),
                    ),
                    GestureDetector(onTap: () => selectedcard(2),
                      child: price(_img,  productDetails[cardindex].quantity3 , _selectedcardindex == 2,pp*4),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomBTN(selected: _selectedcardindex==-1,isNextBtn: false),
                    ),
                  ),
                  SizedBox(width: 80,),
                  IgnorePointer(
                    ignoring: _selectedcardindex==-1,
                    child: GestureDetector(
                      onTap: () =>
                      {
                        showDialog(context: context, builder: (context) =>
                            AlertDialog(
                              backgroundColor: Colors.white,
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                  child: Text("Close",style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'fonts/bolt-semibold.ttf',
                                  ),),
                                ),
                                SizedBox(width: 90,),
                                TextButton(onPressed: () {
                                 new model(cardindex, (_selectedcardindex+1).toString());
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => payment()));
                                },
                                  child: Text("Continue",style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'fonts/bolt-semibold.ttf',
                                  ),),
                                )
                              ],
                              title: Text("Summary",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.black),),
                              contentPadding: EdgeInsets.zero,
                              content: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 15, top: 15),
                                            child: Text("Product : ",
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'fonts/bolt-semibold.ttf',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0, top: 15),
                                            child: Text(productDetails[cardindex].productName,
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'fonts/bolt-semibold.ttf',),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 15, top: 5),
                                            child: Text("Quantity : ",
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'fonts/bolt-semibold.ttf',),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0, top: 5),
                                            child: Text(productDetails[cardindex].quantity3,
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'fonts/bolt-semibold.ttf',),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 15, top: 5),
                                            child: Text("Price : ",
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'fonts/bolt-semibold.ttf',),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0, top: 5),
                                            child: Text("",
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'fonts/bolt-semibold.ttf',),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CustomBTN(selected: _selectedcardindex != -1,isNextBtn: true),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,)
            ],
          ),
        ],
      ),
    );
  }
}
