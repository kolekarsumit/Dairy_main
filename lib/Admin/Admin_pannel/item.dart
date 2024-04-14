import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Background/image_change.dart';
import 'ProductForm.dart';
import 'details_model.dart';

class Itemproduct extends StatefulWidget {
  const Itemproduct({Key? key}) : super(key: key);

  @override
  State<Itemproduct> createState() => _ItemState();
}

class _ItemState extends State<Itemproduct> {
  List<Product> productDetails = [];

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
    return Container(

      color: Colors.white24,

      width:MediaQuery.of(context).size.width,
      height:600,
      // color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 10),
              child: Text(
                "SET PRODUCT DETAILS",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _showPopup(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 25, bottom: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showPopup(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellowAccent,
                                border: Border.all(
                                    color: Colors.black54, width: 1)),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: Text(
                              "Add Product",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showPopup(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 25, bottom: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageChange()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellowAccent,
                                border: Border.all(
                                    color: Colors.black54, width: 1)),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: Text(
                              "Select Theme",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productDetails.length,
                itemBuilder: (context, index) {
                  return ProductForm(index, productDetails,
                      (List<Product> updatedList) {
                    productDetails = updatedList;
                    String productListJson = jsonEncode(productDetails);
                    print('updated ${productListJson}');
                    saveProductList();
                    setState(() {});
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPopup(BuildContext context) async {
    String newProductId = '';
    String newProductName = '';
    String newPrice1 = '';
    String newQuantity1 = '';
    String newPrice2 = '';
    String newQuantity2 = '';
    String newPrice3 = '';
    String newQuantity3 = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Details'),
          content: SingleChildScrollView(
            child: Container(
              // width: MediaQuery.of(context).size.width * 0.8,
              // height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      newProductId = value;
                    },
                    decoration: InputDecoration(labelText: 'Product ID'),
                  ),
                  TextField(
                    onChanged: (value) {
                      newProductName = value;
                    },
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            newQuantity1 = value;
                          },
                          decoration: InputDecoration(labelText: 'Quantity 1.'),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            newPrice1 = value;
                          },
                          decoration: InputDecoration(labelText: 'Price 1.'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            newQuantity2 = value;
                          },
                          decoration: InputDecoration(labelText: 'Quantity 2.'),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            newPrice2 = value;
                          },
                          decoration: InputDecoration(labelText: 'Price 2.'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            newQuantity3 = value;
                          },
                          decoration: InputDecoration(labelText: 'Quantity 3.'),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            newPrice3 = value;
                          },
                          decoration: InputDecoration(labelText: 'Price 3.'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                setState(() {
                  productDetails.add(Product(
                    productId: newProductId,
                    productName: newProductName,
                    price1: newPrice1,
                    quantity1: newQuantity1,
                    price2: newPrice2,
                    quantity2: newQuantity2,
                    price3: newPrice3,
                    isEnable: true,
                    quantity3: newQuantity3,
                  ));

                  saveProductList();
                });
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void saveProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String productListJson = jsonEncode(productDetails);
    print('added list ${productListJson}');
    prefs.setString('productList', productListJson);
  }
}
