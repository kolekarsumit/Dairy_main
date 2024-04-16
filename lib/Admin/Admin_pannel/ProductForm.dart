
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DetailsPopup.dart';
import 'details_model.dart';


class ProductForm extends StatefulWidget {
  final int id;
  final List<Product> productDetail;
  Function(List<Product>) callback;
  ProductForm(this.id, this.productDetail,this.callback);


  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  List<Product> productDetails = [];
  Product? product;

  @override
  void initState() {
    productDetails=widget.productDetail;
    super.initState();
  }
  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailsPopup(productDetails[widget.id],(Product product){
          productDetails[widget.id]=product;
          print(product.toJson());
          widget.callback(productDetails);
        });
      },
    );
  }

  void remove(){
    productDetails.removeAt(widget.id);
    widget.callback(productDetails);
  }
  @override
  Widget build(BuildContext context) {
    int id_ = widget.id;
    Product product = productDetails[id_];
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                product.productId,
                style: TextStyle(
                  fontFamily: 'fonts/bolt-semibold.ttf',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                product.productName,
                style: TextStyle(
                  fontFamily: 'bolt-regular.ttf',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildQuantityOption(product.quantity1),
                  buildQuantityOption(product.quantity2),
                  buildQuantityOption(product.quantity3),
                ],
              ),
              Column(
                children: [
                  buildQuantityOption(product.price1),
                  buildQuantityOption(product.price2),
                  buildQuantityOption(product.price3),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  productDetails[widget.id].isEnable=true;
                  widget.callback(productDetails);
                },
                child: Text("Enable",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  productDetails[widget.id].isEnable=false;
                  widget.callback(productDetails);
                },
                child: Text("Disable",style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showDetailsDialog(context);
                },
                child: Text("Details",style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  _showProductInformation(context,product.productId,product.productName,product.price1,product.quantity1,product.price2,product.quantity2,product.price3,product.quantity2);

                },
                child: Text("Edit",style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                ),
              ),
              IconButton(
                onPressed: () {
                  remove();
                },
                icon: Icon(
                  Icons.remove_circle,
                  size: 30,
                  color: Colors.red,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuantityOption(String quantity) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          quantity,
          style: TextStyle(
            fontFamily: 'fonts/bolt-semibold.ttf',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _showProductInformation(BuildContext context, String productId, String productName, String price1, String price2, String price3, String quantity1, String quantity2, String quantity3) {
    TextEditingController _productIdController = TextEditingController(text: productId);
    TextEditingController _productNameController = TextEditingController(text: productName);
    TextEditingController _price1Controller = TextEditingController(text: price1);
    TextEditingController _price2Controller = TextEditingController(text: price2);
    TextEditingController _price3Controller = TextEditingController(text: price3);
    TextEditingController _quantity1Controller = TextEditingController(text: quantity1);
    TextEditingController _quantity2Controller = TextEditingController(text: quantity2);
    TextEditingController _quantity3Controller = TextEditingController(text: quantity3);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Product Information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _productIdController,
                  decoration: InputDecoration(labelText: 'New Product ID'),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(labelText: 'New Product Name'),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _price1Controller,
                        decoration: InputDecoration(labelText: 'New Price1'),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: TextField(
                        controller: _quantity1Controller,
                        decoration: InputDecoration(labelText: 'New Quantity1'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _price2Controller,
                        decoration: InputDecoration(labelText: 'New Price2'),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: TextField(
                        controller: _quantity2Controller,
                        decoration: InputDecoration(labelText: 'New Quantity2'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _price3Controller,
                        decoration: InputDecoration(labelText: 'New Price3'),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: TextField(
                        controller: _quantity3Controller,
                        decoration: InputDecoration(
                            labelText: 'New Quantity3'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String newProductId = _productIdController.text;
                String newProductName = _productNameController.text;
                String newPrice1 = _price1Controller.text;
                String newPrice2 = _price2Controller.text;
                String newPrice3 = _price3Controller.text;
                String newQuantity1 = _quantity1Controller.text;
                String newQuantity2 = _quantity2Controller.text;
                String newQuantity3 = _quantity3Controller.text;

                // Update the productDetails list with the new data
                productDetails[widget.id] = Product(
                  productId: newProductId,
                  productName: newProductName,
                  price1: newPrice1,
                  quantity1: newQuantity1,
                  price2: newPrice2,
                  quantity2: newQuantity2,
                  price3: newPrice3,
                  quantity3: newQuantity3,
                  isEnable: false,
                );

                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }



}