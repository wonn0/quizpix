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
      child: Text(
        style: Theme.of(context).textTheme.bodyText1?.merge(TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
        )),
        widget.label,
      ),
    );
  }
}