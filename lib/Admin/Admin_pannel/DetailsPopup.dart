import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'details_model.dart';

class DetailsPopup extends StatefulWidget {
  Product product;
  Function(Product) callback;
  DetailsPopup(this.product,this.callback);
  @override
  _DetailsPopupState createState() => _DetailsPopupState();
}

class _DetailsPopupState extends State<DetailsPopup> {


  TextEditingController nameController = TextEditingController();
  TextEditingController p1Controller = TextEditingController();
  TextEditingController p2Controller = TextEditingController();
  TextEditingController p3Controller = TextEditingController();
  TextEditingController q3Controller = TextEditingController();
  TextEditingController q2Controller = TextEditingController();
  TextEditingController q1Controller = TextEditingController();


  TextEditingController fatController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  DateTime? insertingDate;
  DateTime? expiryDate;
  TextEditingController stock=TextEditingController();

  @override
  void initState() {
    super.initState();


    nameController.text=widget.product.productName.toString();
    p1Controller.text=widget.product.price1.toString();
    p2Controller.text=widget.product.price2.toString();
    p3Controller.text=widget.product.price3.toString();
    q1Controller.text=widget.product.quantity1.toString();
    q2Controller.text=widget.product.quantity2.toString();
    q3Controller.text=widget.product.quantity3.toString();



    fatController.text=widget.product.fat.toString();
    proteinController.text=widget.product.protein.toString();
    caloriesController.text=widget.product.calories.toString();
    stock.text=widget.product.stock.toString();
  }
  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        expiryDate = picked;
        String expiryDateStr=DateFormat('yyyy-MM-dd').format(expiryDate!);
        widget.product.expiryDate=expiryDateStr;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {

      setState(() {
        insertingDate = picked;
        String insertingDateStr=DateFormat('yyyy-MM-dd').format(insertingDate!);
        widget.product.insertionDate=insertingDateStr;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Details", style: TextStyle(
          fontFamily: 'fonts/bolt-semibold.ttf'
      ),),
      content: Container(
        height: 400,
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: fatController,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Fat',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: proteinController,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Protein',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: caloriesController,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Calories'),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: stock,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Stocks'),
              ), TextField(
                controller: nameController,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'name'),
              ),
              TextField(
                controller: p1Controller,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Price 1'),
              ),   TextField(
                controller: p2Controller,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Price 2'),
              ),   TextField(
                controller: p3Controller,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Price 3'),
              ), TextField(
                controller: q1Controller,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Quantity 1'),
              ),TextField(
                controller: q2Controller,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Quantity 2'),
              ),TextField(
                controller: q3Controller,
                style: TextStyle(
                    fontFamily: 'fonts/bolt-semibold.ttf'
                ),
                decoration: InputDecoration(labelText: 'Quantity 3'),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text('Inserted Date',
                      style: TextStyle(
                          fontFamily: 'fonts/bolt-semibold.ttf'
                      ),),
                  ),
                  SizedBox(width: 10),
                  Text('${insertingDate != null ? DateFormat('yyyy-MM-dd').format(insertingDate!) : '${widget.product.insertionDate}'}'),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      _selectExpiryDate(context);
                    },
                    child: Text('Expiry Date    ',
                      style: TextStyle(
                          fontFamily: 'fonts/bolt-semibold.ttf'
                      ),),
                  ),
                  SizedBox(width: 10),
                  Text('${expiryDate != null ? DateFormat('yyyy-MM-dd').format(expiryDate!) : '${widget.product.expiryDate}'}'),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {

            widget.product.productName=nameController.text;
            widget.product.price1=p1Controller.text;
            widget.product.price2=p2Controller.text;
            widget.product.price3=p3Controller.text;
            widget.product.quantity1=q1Controller.text;
            widget.product.quantity2=q2Controller.text;
            widget.product.quantity3=q3Controller.text;


            widget.product.fat=double.parse(fatController.text);
            widget.product.protein=int.parse(proteinController.text);
            widget.product.calories=int.parse(caloriesController.text);
            widget.product.stock=int.parse(stock.text);
            widget.callback(widget.product);
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}