import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle
            ),
            child: Icon(
              Icons.audiotrack,
              color: Colors.green,
              size: 30.0,
            ),
          ),
          const Text('hell'),
        ],
      )
    );
  }
}