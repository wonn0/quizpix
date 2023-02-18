import 'package:flutter/material.dart';

class QButton extends StatefulWidget {
  const QButton(
      {super.key, required this.label, required this.onPress, this.icon});

  final String label;
  final Function() onPress;
  final Widget? icon;

  @override
  State<QButton> createState() => _QButtonState();
}

class _QButtonState extends State<QButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPress,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          children: [
            widget.icon ?? const SizedBox(),
            Text(
              style:
                  Theme.of(context).textTheme.bodyLarge?.merge(const TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      )),
              widget.label,
            ),
          ],
        ));
  }
}
