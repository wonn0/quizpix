import 'package:flutter/material.dart';
import 'package:quizpix/constants/choices.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.index,
    required this.type,
    required this.question,
    required this.answer,
    required this.choices,
    this.selAnswer,
  });

  final int index;
  final String type;
  final String question;
  final String answer;
  final List<dynamic>? choices;
  final String? selAnswer;

  Color getColor(
      String type, String? choice, String answer, String? selAnswer) {
    if (type == 'multiple_choice' || type == 'true_or_false') {
      if (selAnswer == null) {
        if (choice == answer) {
          return const Color(0xfff69036);
        }
        return const Color(0xff909090);
      } else {
        if ((selAnswer == answer) && (choice == answer)) {
          return const Color(0xff86dc3d);
        } else if ((selAnswer != answer) && (choice == answer)) {
          return const Color(0xfff69036);
        } else if ((selAnswer != answer) && (choice == selAnswer)) {
          return const Color(0xffd0342c);
        }
        return const Color(0xff909090);
      }
    } else {
      if (selAnswer == null) {
        return const Color(0xfff69036);
      } else {
        if ((selAnswer.trim().toLowerCase() != answer.trim().toLowerCase())) {
          return const Color(0xffd0342c);
        }
        return const Color(0xff86dc3d);
      }
    }
  }

  Widget getCorrectAnswer(BuildContext context) {
    if (selAnswer != null &&
        (selAnswer!.trim().toLowerCase() != answer.trim().toLowerCase())) {
      return Text(
          style: Theme.of(context).textTheme.bodyLarge!.merge(const TextStyle(
                color: Color(0xfff69036),
              )),
          'Correct answer: $answer');
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    if (type == 'multiple_choice') {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 110.0,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .merge(const TextStyle(
                            color: Color(0xff909090),
                          )),
                      '${index + 1}. $question'),
                  //choices
                  Expanded(
                      child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: choices!.length,
                    itemBuilder: (context, index) {
                      return Text(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .merge(TextStyle(
                                color: getColor('multiple_choice',
                                    choices![index], answer, selAnswer),
                              )),
                          '${choicesMap[index + 1]}. ${choices![index]}');
                    },
                  )),
                ],
              ),
            ),
          )
        ],
      );
    }

    if (type == 'true_or_false') {
      return Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .merge(const TextStyle(
                        color: Color(0xff909090),
                      )),
                  '${index + 1}. $question'),
              Text(
                  style: Theme.of(context).textTheme.bodyLarge!.merge(TextStyle(
                        color: getColor(
                            'true_or_false', 'true', answer, selAnswer),
                      )),
                  'a. True'),
              Text(
                  style: Theme.of(context).textTheme.bodyLarge!.merge(TextStyle(
                        color: getColor(
                            'true_or_false', 'false', answer, selAnswer),
                      )),
                  'b. False'),
            ]),
          ))
        ],
      );
    }

    return Row(
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .merge(const TextStyle(
                              color: Color(0xff909090),
                            )),
                        '${index + 1}. $question'),
                    Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .merge(TextStyle(
                              color: getColor(
                                  'identification', null, answer, selAnswer),
                            )),
                        'Answer: ${selAnswer ?? answer}'),
                    getCorrectAnswer(context),
                  ],
                )))
      ],
    );
  }
}
