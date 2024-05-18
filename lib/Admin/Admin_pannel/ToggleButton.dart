import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final int id;
  final Function(List<Product>) callback;
  final List<Product> productDetails;

  ToggleButton({
    required this.id,
    required this.callback,
    required this.productDetails,
  });

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isEnable = true;
              widget.productDetails[widget.id].isEnable = true;
              widget.callback(widget.productDetails);
            });
          },
          child: Text(
            "Enable",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              isEnable ? Colors.green : Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 10), // Add some spacing between buttons
        ElevatedButton(
          onPressed: () {
            setState(() {
              isEnable = false;
              widget.productDetails[widget.id].isEnable = false;
              widget.callback(widget.productDetails);
            });
          },
          child: Text(
            "Disable",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              isEnable ? Colors.grey : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

class Product {
  bool isEnable;
  Product({this.isEnable = false});
}

