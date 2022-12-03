import 'package:flutter/material.dart';
import 'package:quizpix/constants/choices.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({super.key, required this.index, required this.type, required this.question, required this.answer, required this.choices});

  final int index;
  final int type;
  final String question;
  final String answer;
  final List<String>? choices;

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return Flexible(
        child: Container(
          height: 110.0,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: Theme.of(context).textTheme.bodyText1!.merge(const TextStyle(
                  color: Color(0xff909090),
                )),
                '${index+1}. $question'
              ),
              //choices
              Expanded(
                child: ListView.builder(
                itemCount: choices!.length,
                itemBuilder: (context, index) {
                  return Text(
                    style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                      color: answer == choices![index] ? Theme.of(context).colorScheme.primary : const Color(0xff909090),
                    )),
                    '${choicesMap[index + 1]}. ${choices![index]}'
                  );
                },
              )
              ),
            ],
          ),
        ),
      );
    }

    if (type == 2) {
      return Flexible(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: Theme.of(context).textTheme.bodyText1!.merge(const TextStyle(
                  color: Color(0xff909090),
                )),
                '${index+1}. $question'
              ),
              Text(
                style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                  color: answer == 'true' ? Theme.of(context).colorScheme.primary : const Color(0xff909090),
                )),
                'a. True'
              ),
              Text(
                style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                  color: answer == 'false' ? Theme.of(context).colorScheme.primary : const Color(0xff909090),
                )),
                'b. False'
              ),
            ]
          ),
        )
      );
    }

    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            style: Theme.of(context).textTheme.bodyText1!.merge(const TextStyle(
              color: Color(0xff909090),
            )),
            '${index+1}. $question'
          ),
          Text(
            style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
              color: Theme.of(context).colorScheme.primary,
            )),
            'Answer: $answer'
          ),
          ],
        )
      )
    );
  }
}