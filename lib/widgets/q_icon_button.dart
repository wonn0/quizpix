import 'package:flutter/material.dart';

class QIconButton extends StatelessWidget {
  const QIconButton({super.key, required this.onPress, required this.icon});

  final Function() onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50.0, 30.0),
      ),
      child: Icon(
        icon,
        size: 30.0,
        color: const Color(0xffffffff),
      ),
    );
  }
}
