import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton(
      {super.key,
      required this.isFree,
      required this.isActive,
      required this.onPress});

  final bool isFree;
  final bool isActive;
  final Function() onPress;

  IconData iconPicker(bool x) {
    if (x) {
      return Icons.emoji_objects_outlined;
    }
    return Icons.diamond_outlined;
  }

  String textPicker(bool x) {
    if (x) {
      return "FREE";
    }
    return "PREMIUM";
  }

  Color colorPicker(bool y) {
    if (y) {
      return const Color(0xfff69036);
    }
    return const Color(0xffd3d3d3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      width: 156.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(4.0, 4.0),
            spreadRadius: 1,
            blurRadius: 12,
          ),
        ],
        color: const Color(0xfffafafa),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
            child: Icon(
              iconPicker(isFree),
              size: 30.0,
              color: colorPicker(isActive),
            ),
          ),
          Text(
            textPicker(isFree),
            style: TextStyle(
              color: colorPicker(isActive),
            ),
          ),
        ],
      ),
    );
  }
}
