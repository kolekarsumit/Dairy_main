import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Admin/Admin_pannel/details_model.dart';
class CustomAnimationWidget extends StatefulWidget {
  final Widget child;
  final bool startAnimation;

  const CustomAnimationWidget({Key? key, required this.child, required this.startAnimation})
      : super(key: key);

  @override
  _CustomAnimationWidgetState createState() => _CustomAnimationWidgetState();
}

class _CustomAnimationWidgetState extends State<CustomAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    if (widget.startAnimation) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant CustomAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startAnimation && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.startAnimation && _controller.isAnimating) {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + _controller.value * 0.5,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}