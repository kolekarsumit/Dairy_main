
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
}