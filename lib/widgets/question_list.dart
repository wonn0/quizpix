import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/widgets/question_item.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({super.key, required this.questions});

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return QuestionItem(
                    index: index,
                    type: questions[index].type,
                    question: questions[index].question,
                    answer: questions[index].answer,
                    choices: questions[index].choices!);
              },
            )
          ],
        ))
      ],
    );
  }
}
