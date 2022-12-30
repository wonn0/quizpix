import 'package:flutter/material.dart';

class AnswerDialog extends StatefulWidget {
  const AnswerDialog({
    super.key,
    required this.answerController,
    required this.correctAnswer,
    required this.onAnswer,
  });

  final TextEditingController answerController;
  final String correctAnswer;
  final Function(String, String) onAnswer;

  @override
  State<AnswerDialog> createState() => _AnswerDialogState();
}

class _AnswerDialogState extends State<AnswerDialog> {
  @override
  void initState() {
    super.initState();

    widget.answerController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      contentPadding: const EdgeInsets.only(
          left: 20.0, top: 20.0, right: 20.0, bottom: 0.0),
      actionsPadding: const EdgeInsets.only(right: 20.0, bottom: 8.0),
      title: const Text(
        'Answer',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color: Color(0xfff69036),
        ),
      ),
      content: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: widget.answerController,
                style: const TextStyle(
                  color: Color(0xff6d5271),
                  fontSize: 16.0,
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff6d5271),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff6d5271),
                    ),
                  ),
                  filled: false,
                  hintText: 'Type your answer here!',
                  hintStyle: TextStyle(
                    color: Color(0xff909090),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onAnswer(widget.answerController.text, widget.correctAnswer);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(32, 32),
            backgroundColor: const Color(0xfff69036),
            elevation: 4.0,
          ),
          child: const Text('Submit', style: TextStyle(fontSize: 16.0)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(32, 32),
            backgroundColor: const Color(0xff6d5271),
            elevation: 4.0,
          ),
          child: const Text('Cancel', style: TextStyle(fontSize: 16.0)),
        ),
      ],
    );
  }
}
