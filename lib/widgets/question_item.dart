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
  final int type;
  final String question;
  final String answer;
  final List<String>? choices;
  final String? selAnswer;

  Color getColor(int type, String? choice, String answer, String? selAnswer) {
    if (type == 1 || type == 2) {
      if (selAnswer == null) {
        if (choice == answer) {
          return const Color(0xfff69036);
        }
        return const Color(0xff909090);
      } else {
        if ((choice == selAnswer) && (selAnswer != answer)) {
          return const Color(0xffd0342c);
        } else if (choice == answer) {
          return const Color(0xff86dc3d);
        }
        return const Color(0xff909090);
      }
    } else {
      if (selAnswer == null) {
        return const Color(0xfff69036);
      } else {
        if ((selAnswer != answer)) {
          return const Color(0xffd0342c);
        }
        return const Color(0xff86dc3d);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
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
                          .bodyText1!
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
                              .bodyText1!
                              .merge(TextStyle(
                                color: getColor(
                                    1, choices![index], answer, selAnswer),
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

    if (type == 2) {
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
                      .bodyText1!
                      .merge(const TextStyle(
                        color: Color(0xff909090),
                      )),
                  '${index + 1}. $question'),
              Text(
                  style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                        color: getColor(2, 'true', answer, selAnswer),
                      )),
                  'a. True'),
              Text(
                  style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                        color: getColor(2, 'false', answer, selAnswer),
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
                            .bodyText1!
                            .merge(const TextStyle(
                              color: Color(0xff909090),
                            )),
                        '${index + 1}. $question'),
                    Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(TextStyle(
                              color: getColor(3, null, answer, selAnswer),
                            )),
                        'Answer: ${selAnswer ?? answer}'),
                  ],
                )))
      ],
    );
  }
}
