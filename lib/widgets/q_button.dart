import 'package:flutter/material.dart';

class QButton extends StatefulWidget {
  const QButton({super.key, required this.label, required this.onPress});

  final String label;
  final Function() onPress;

  @override
  State<QButton> createState() => _QButtonState();
}

class _QButtonState extends State<QButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress, 
      child: Text(
        style: Theme.of(context).textTheme.bodyText1?.merge(const TextStyle(
          color: Color(0xffffffff),
        )),
        widget.label,
      ),
    );
  }
}