import 'package:flutter/material.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key, required this.label, required this.icon, required this.onPress, required this.isLeft});

  final String label;
  final bool isLeft;
  final Widget icon;
  final Function() onPress;

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLeft) {
      return Container(
        margin: const EdgeInsets.only(left: 80.0),
        child: Material(
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: InkWell(
              onTap: widget.onPress,
              customBorder: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                ),
              ),
              child: Container(
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
                    Expanded(
                      flex: 1,
                      child: Text(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1?.merge(const TextStyle(
                          color: Color(0xffffffff),
                        )),
                        widget.label
                      ),
                    )
                  ],
                )
              )
            )
          )
        )
      );
    }

    return Container(
      margin: const EdgeInsets.only(right: 80.0),
        child: Material(
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: InkWell(
            onTap: widget.onPress,
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Container(
              height: 120.0,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1?.merge(const TextStyle(
                        color: Color(0xffffffff),
                      )),
                      widget.label
                    ),
                  ),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffffffff),
                    ),
                    child: widget.icon,
                  ),
                ],
              )
            )
          )
        )
      )
    );
  }
}