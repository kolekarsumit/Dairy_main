import 'package:flutter/cupertino.dart';

class logo1_ extends StatefulWidget {
  double _width;
  double _height;


  logo1_(this._width, this._height);

  @override
  State<logo1_> createState() => _logo1_State();
}

class _logo1_State extends State<logo1_> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width,
      height: widget._height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logo.png"),
          fit: BoxFit.cover,
        ),
      ),
    );;
  }
}
