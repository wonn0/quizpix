import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/widgets/question_item.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({super.key, required this.questions});

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return QuestionItem(
                  index: index, 
                  type: questions[index].type, 
                  question: questions[index].question, 
                  answer: questions[index].answer, 
                  choices: questions[index].choices!
                );
              },
            )
          ],
        )
      ),
    );
  }
}