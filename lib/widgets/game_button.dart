import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    super.key,
    required this.label,
    required this.onPress,
    this.isMC = false,
    this.isAnswer = false,
  });

  final String label;
  final Function() onPress;
  final bool isMC;
  final bool isAnswer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isAnswer == true
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
          ),
          child: InkWell(
            onTap: onPress,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: isMC == true
                  ? Text(
                      label,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Color(0xfff5f5f5),
                      ),
                    )
                  : Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xfff5f5f5),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
