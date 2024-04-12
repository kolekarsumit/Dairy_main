import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class watercontainer extends StatefulWidget {
  const watercontainer({super.key});

  @override
  State<watercontainer> createState() => _watercontainerState();
}

class _watercontainerState extends State<watercontainer>

    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _waveAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
          animation: _waveAnimation,
          builder: (context, child) {
            return Center(
              child: Container(
                width: 150.0,
                height: 200.0,
                child: LiquidLinearProgressIndicator(
                  value: _waveAnimation.value,
                  // Set initial value
                  valueColor: const AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                  borderColor: Colors.black,
                  borderWidth: 5.0,
                  direction: Axis.vertical,
                ),
              ),
            );
          }),
    );
  }
}


class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    var width = size.width;
    var height = size.height;

    Path path = Path();
    path.moveTo(width / 2, height / 5);
    path.arcToPoint(Offset(width / 5, height / 2),
        radius: Radius.elliptical(width / 5, height / 5),
        rotation: math.pi / 2);
    path.arcToPoint(Offset(width / 2, height / 1.25),
        radius: Radius.elliptical(width / 2.5, height / 2.5),
        rotation: math.pi / 2);
    path.arcToPoint(Offset(width / 1.25, height / 2),
        radius: Radius.elliptical(width / 5, height / 5),
        rotation: math.pi / 2);
    path.arcToPoint(Offset(width / 2, height / 5),
        radius: Radius.elliptical(width / 2.5, height / 2.5),
        rotation: math.pi / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


