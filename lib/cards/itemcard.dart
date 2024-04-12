import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Admin/Admin_pannel/details_model.dart';
import '../theme/Animation.dart';
import '../theme/colors.dart';

class item_card extends StatefulWidget {
 Product product;
String img;
bool select;
  item_card(this.product,this.img, this.select);

  @override
  State<item_card> createState() => _item_cardState();
}

class _item_cardState extends State<item_card> with TickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    if (widget.select) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant item_card oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.select && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.select && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.select ? AppColor.selectedbordercol: AppColor.primarybordercol,
          borderRadius: BorderRadius.circular(25), // Container color
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(4,4),
            ),   BoxShadow(
              color:  AppColor.primarygray,
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(-4,-4),
            ),

          ],

      ),
      margin: EdgeInsets.only(left: 60),
      width: 330,
      height: 200,

      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.product.productName,
                  style: TextStyle(
                    fontFamily: 'bolt-semibold.ttf',
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(),
                GestureDetector(
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
                                    fontFamily: 'bolt-regular.ttf',
                                  ),),
                                )
                              ],
                              title: Text("Product Details",
                                style: TextStyle(
                                    fontFamily: 'bolt-semibold.ttf',
                                    color: Colors.black),),
                              contentPadding: EdgeInsets.zero,
                              content: SingleChildScrollView(
                                child: Container(
                                  // height: 150,
                                  // width: 200,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            child: Text(
                                              "Fat : ", style: TextStyle(
                                              color:Colors.black,
                                                fontFamily: 'bolt-regular.ttf',
                                                fontSize: 14
                                            ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 15),
                                            child: Text(
                                              widget.product.fat.toString(), style: TextStyle(
                                                fontFamily: 'bolt-regular.ttf',
                                                color: Colors.black,
                                                fontSize: 14
                                            ),),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 5),
                                            child: Text(
                                              "Calories : ", style: TextStyle(
                                                fontFamily: 'bolt-regular.ttf',
                                                color: Colors.black,
                                                fontSize: 14
                                            ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 5),
                                            child: Text(widget.product.calories.toString(),
                                              style: TextStyle(

                                                  fontFamily: 'bolt-regular.ttf',
                                                  color: Colors.black,
                                                  fontSize: 14
                                              ),),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 5),
                                            child: Text(

                                              "Protien : ", style: TextStyle(

                                                fontFamily: 'bolt-regular.ttf',
                                                color: Colors.black,
                                                fontSize: 14
                                            ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 5),
                                            child: Text(widget.product.protein.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14
                                              ),),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 5),
                                            child: Text(
                                              "Product inserted Data : ",
                                              style: TextStyle(

                                                  fontFamily: 'bolt-regular.ttf',
                                                  color: Colors.black,
                                                  fontSize: 14
                                              ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 5),
                                            child: Text(
                                              widget.product.insertionDate.toString(), style: TextStyle(

                                                fontFamily: 'bolt-regular.ttf',
                                                color: Colors.black,
                                                fontSize: 14
                                            ),),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 5),
                                            child: Text("Product Expiry Data : ",
                                              style: TextStyle(
                                                  fontFamily: 'bolt-regular.ttf',
                                                  color: Colors.black,
                                                  fontSize: 14
                                              ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 5),
                                            child: Text(
                                              widget.product.expiryDate.toString(), style: TextStyle(
                                                fontFamily: 'bolt-regular.ttf',
                                                color: Colors.black,
                                                fontSize: 14
                                            ),),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 5),
                                            child: Text("Stock : ",
                                              style: TextStyle(
                                                  fontFamily: 'bolt-regular.ttf',
                                                  color: Colors.black,
                                                  fontSize: 14
                                              ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 5),
                                            child: Text(
                                              widget.product.stock.toString(), style: TextStyle(
                                                fontFamily: 'bolt-regular.ttf',
                                                color: Colors.black,
                                                fontSize: 14
                                            ),),
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              )

                          ))
                    },
                    child: Icon(CupertinoIcons.exclamationmark_octagon,color: Colors.white,),
                ),
              ],
            ),

            CustomAnimationWidget(
              startAnimation: widget.select,
              child: Image.asset(
                widget.img,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1)),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  "Select",
                  style: TextStyle(
                      fontFamily: 'bolt-semibold.ttf',
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

