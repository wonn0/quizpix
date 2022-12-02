import 'package:flutter/material.dart';

class QuizItem extends StatefulWidget {
  const QuizItem({super.key});

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 80.0,
      child: Row(
        children: [
          const Text('hey'),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffd9d9d9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text('wasaup'),
          )
        ],
      ),
    );
  }
}