import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomArc extends StatelessWidget {
  final double diameter;
  final Widget? text;

  const CustomArc({super.key, this.diameter = 200, this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.7,
          child: Center(
            child: CustomPaint(
              painter: Painter(),
              size: Size(diameter, diameter),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 148.0),
            child: text!,
          ),
        ),
      ],
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xfff69036);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi / 8,
      6 * math.pi / 8,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
