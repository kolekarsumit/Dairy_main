import 'package:flutter/material.dart';
import 'package:dairy/theme/colors.dart';
import 'package:dairy/theme/Animation.dart';

class CustomBTN extends StatelessWidget {
  final bool selected;
  final bool isNextBtn;

  const CustomBTN({
    Key? key,
    required this.selected,
    required this.isNextBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimationWidget(

      startAnimation: selected,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColor.primarygray : AppColor.lightgray,
              ),
            ),
            Icon(
              isNextBtn ? Icons.arrow_forward_ios_sharp : Icons.arrow_back_ios_sharp,
              size: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
