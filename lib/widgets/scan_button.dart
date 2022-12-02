import 'package:flutter/material.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key, required this.label, required this.icon, required this.onPress});

  final String label;
  final Widget icon;
  final Function() onPress;

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(100),
          bottomLeft: Radius.circular(100)
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      height: 120.0,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100.0,
            width: 100.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffffffff),
            ),
            child: widget.icon,
          ),
          Text(
            style: Theme.of(context).textTheme.headline1?.merge(const TextStyle(
              color: Color(0xffffffff),
            )),
            widget.label
          ),
        ],
      )
    );
  }
}