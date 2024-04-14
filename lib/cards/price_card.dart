import 'package:dairy/Admin/Admin_pannel/details_model.dart';
import 'package:dairy/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class price extends StatelessWidget {

  String img;
  String quantity;
  bool select=false;
  String total;


  price(this.img, this.quantity,this.select,this.total);

  @override
  Widget build(BuildContext context) {
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;


    return Container(

      decoration: BoxDecoration(
          color: select ? AppColor.selectedbordercol: AppColor.primarybordercol,
          borderRadius: BorderRadius.circular(10), // Container color
        boxShadow: [
          BoxShadow(
            color: Colors.white, // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 8, // Blur radius
            offset: Offset(4,4), // Offset from the top
          ),   BoxShadow(
            color:  AppColor.primarygray, // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 8, // Blur radius
            offset: Offset(-4,-4), // Offset from the top
          ),

        ],

      ),
      margin: EdgeInsets.only(left: 60),
      width: 250,
      height:320,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              SizedBox(height: 10,),

              Text("${quantity} ML",style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                fontFamily: 'bolt-semibold.ttf',
                ),),



              SizedBox(),



             Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),


             Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                          // color: Colors.black,
                          width: 1
                      )
                  ),
                  padding:  EdgeInsets.symmetric(vertical: 8,horizontal: 28),
                  child: Text(total,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'bolt-regular.ttf',
                    ),),
                ),


              SizedBox()
            ],
          ),












    );
  }
}
