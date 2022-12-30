import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  const HealthBar({super.key, required this.healthFactor});

  final double healthFactor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          height: 8.0,
          width: 82.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: const Color(0xffd0342c),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        Container(
          height: 6.0,
          width: 80.0 - (healthFactor * 80),
          margin: const EdgeInsets.only(left: 1.0, right: 1.0),
          decoration: BoxDecoration(
            color: const Color(0xffd0342c),
            border: Border.all(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    );
  }
}
