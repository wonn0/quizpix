import 'package:flutter/material.dart';
import 'package:quizpix/constants/choices.dart';
import 'package:quizpix/widgets/edit_dialog.dart';
import 'package:quizpix/models/question.dart';

class EditQuestionItem extends StatefulWidget {
  const EditQuestionItem({
    super.key,
    required this.index,
    required this.type,
    required this.question,
    required this.answer,
    required this.choices,
    required this.updateTemp,
  });

  final int index;
  final int type;
  final String question;
  final String answer;
  final List<String> choices;
  final Function(Question, int) updateTemp;

  @override
  State<EditQuestionItem> createState() => _EditQuestionItemState();
}

class _EditQuestionItemState extends State<EditQuestionItem> {
  int type = 1;
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final TextEditingController choiceAController = TextEditingController();
  final TextEditingController choiceBController = TextEditingController();
  final TextEditingController choiceCController = TextEditingController();
  final TextEditingController choiceDController = TextEditingController();

  @override
  void initState() {
    super.initState();

    type = widget.type;
  }

  void updateType(int newType) {
    setState(() {
      type = newType;
    });
  }

  Future<dynamic> displayEditDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditDialog(
            index: widget.index,
            type: type,
            question: widget.question,
            answer: widget.answer,
            choices: widget.choices,
            questionController: questionController,
            answerController: answerController,
            choiceAController: choiceAController,
            choiceBController: choiceBController,
            choiceCController: choiceCController,
            choiceDController: choiceDController,
            updateTemp: widget.updateTemp,
            updateType: updateType,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 130.0,
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .merge(const TextStyle(
                                color: Color(0xff909090),
                              )),
                          '${widget.index + 1}. ${widget.question}'),
                      Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.only(right: 8.0),
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 30.0,
                              color: Color(0xfff69036),
                            ),
                            onPressed: () {
                              displayEditDialog(context);
                            },
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(right: 8.0),
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 31.0,
                              color: Color(0xff6d5271),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  //choices
                  Expanded(
                      child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.choices.length,
                    itemBuilder: (context, index) {
                      return Text(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .merge(const TextStyle(
                                color: Color(0xff909090),
                              )),
                          '${choicesMap[index + 1]}. ${widget.choices[index]}');
                    },
                  )),

                  Text(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .merge(const TextStyle(
                            color: Color(0xfff69036),
                          )),
                      'Answer: ${choicesMap[widget.choices.indexWhere((choice) => choice == widget.answer) + 1]}. ${widget.answer}'),
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
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .merge(const TextStyle(
                            color: Color(0xff909090),
                          )),
                      '${widget.index + 1}. ${widget.question}'),
                  Row(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.only(right: 8.0),
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 30.0,
                          color: Color(0xfff69036),
                        ),
                        onPressed: () {
                          displayEditDialog(context);
                        },
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(right: 8.0),
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 31.0,
                          color: Color(0xff6d5271),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(
                        color: Color(0xff909090),
                      )),
                  'a. True'),
              Text(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(
                        color: Color(0xff909090),
                      )),
                  'b. False'),
              Text(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(
                        color: Color(0xfff69036),
                      )),
                  'Answer: ${widget.answer == 'true' ? 'a. True' : 'b. False'}'),
            ]),
          ))
        ],
      );
    }

    return Row(
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(
                                  color: Color(0xff909090),
                                )),
                            '${widget.index + 1}. ${widget.question}'),
                        Row(
                          children: [
                            IconButton(
                              padding: const EdgeInsets.only(right: 8.0),
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 30.0,
                                color: Color(0xfff69036),
                              ),
                              onPressed: () {
                                displayEditDialog(context);
                              },
                            ),
                            IconButton(
                              padding: const EdgeInsets.only(right: 8.0),
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 31.0,
                                color: Color(0xff6d5271),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(
                              color: Color(0xfff69036),
                            )),
                        'Answer: ${widget.answer}'),
                  ],
                )))
      ],
    );
  }
}
