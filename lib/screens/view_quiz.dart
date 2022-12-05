import 'package:flutter/material.dart';

class ViewQuiz extends StatefulWidget {
  const ViewQuiz({super.key});

  @override
  State<ViewQuiz> createState() => _ViewQuizState();
}

class _ViewQuizState extends State<ViewQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: const Text('henlo'),
        )
      ),
    );
  }
}