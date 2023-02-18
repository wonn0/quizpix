import 'package:flutter/material.dart';

class QButtonOutline extends StatefulWidget {
  const QButtonOutline({super.key, required this.label, required this.onPress});

  final String label;
  final Function() onPress;

  @override
  State<QButtonOutline> createState() => _QButtonOutlineState();
}

class _QButtonOutlineState extends State<QButtonOutline> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPress,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Text(
        style: Theme.of(context).textTheme.bodyLarge?.merge(TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            )),
        widget.label,
      ),
    );
  }
}
