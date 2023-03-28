import 'package:flutter/material.dart';
import 'package:quizpix/constants/choices.dart';
import 'package:quizpix/helpers/question.dart';
import 'package:quizpix/widgets/edit_dialog.dart';
import 'package:quizpix/models/question.dart';
import 'package:collection/collection.dart';

class EditQuestionItem extends StatefulWidget {
  const EditQuestionItem({
    super.key,
    required this.index,
    required this.question,
    required this.updateTemp,
  });

  final int index;
  final Question question;
  final Function(Question?, int) updateTemp;

  @override
  State<EditQuestionItem> createState() => _EditQuestionItemState();
}

class _EditQuestionItemState extends State<EditQuestionItem> {
  String type = 'multiple_choice';
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final TextEditingController choiceAController = TextEditingController();
  final TextEditingController choiceBController = TextEditingController();
  final TextEditingController choiceCController = TextEditingController();
  final TextEditingController choiceDController = TextEditingController();

  @override
  void initState() {
    super.initState();

    type = widget.question.type;
  }

  @override
  void didUpdateWidget(EditQuestionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.question.type != oldWidget.question.type) {
      type = widget.question.type;
    }
  }

  void updateType(String newType) {
    setState(() {
      type = newType;
    });
  }

  Future<dynamic> displayEditDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return EditDialog(
            index: widget.index,
            question: widget.question,
            type: 'edit',
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

  Future<dynamic> displayDeleteDialog(BuildContext context, int index) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding:
                const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            actionsPadding:
                const EdgeInsets.only(top: 8.0, right: 20.0, bottom: 8.0),
            title: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xfff69036),
                ),
                children: [
                  const TextSpan(text: 'Delete '),
                  TextSpan(
                      text: 'Question ${index + 1}',
                      style: const TextStyle(color: Color(0xff6d5271))),
                  const TextSpan(text: '?'),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  widget.updateTemp(null, index);
                  await deleteQuestion(widget.question);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(32, 32),
                  backgroundColor: const Color(0xfff69036),
                  elevation: 6.0,
                ),
                child: const Text('Delete', style: TextStyle(fontSize: 16.0)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(32, 32),
                  backgroundColor: const Color(0xff6d5271),
                  elevation: 6.0,
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 16.0)),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (type == 'multiple_choice') {
      return Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .merge(const TextStyle(
                                  color: Color(0xff909090),
                                )),
                            '${widget.index + 1}. ${widget.question.question}'),
                      ),
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
                            onPressed: () {
                              displayDeleteDialog(context, widget.index);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  //choices
                  for (var item in widget.question.choices!) ...[
                    Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .merge(const TextStyle(
                              color: Color(0xff909090),
                            )),
                        '${choicesMap[widget.question.choices!.indexOf(item) + 1]}. ${widget.question.choices![widget.question.choices!.indexOf(item)]}')
                  ],
                  // Expanded(
                  //     child: ListView.builder(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: widget.question.choices!.length,
                  //   itemBuilder: (context, index) {
                  //     return Text(
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodyLarge!
                  //             .merge(const TextStyle(
                  //               color: Color(0xff909090),
                  //             )),
                  //         '${choicesMap[index + 1]}. ${widget.question.choices![index]}');
                  //   },
                  // )),

                  Text(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .merge(const TextStyle(
                            color: Color(0xfff69036),
                          )),
                      'Answer: ${choicesMap[widget.question.choices!.indexWhere((choice) => choice == widget.question.answer) + 1]}. ${widget.question.answer}'),
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
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .merge(const TextStyle(
                              color: Color(0xff909090),
                            )),
                        '${widget.index + 1}. ${widget.question.question}'),
                  ),
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
                        onPressed: () {
                          displayDeleteDialog(context, widget.index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .merge(const TextStyle(
                        color: Color(0xff909090),
                      )),
                  'a. True'),
              Text(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .merge(const TextStyle(
                        color: Color(0xff909090),
                      )),
                  'b. False'),
              Text(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .merge(const TextStyle(
                        color: Color(0xfff69036),
                      )),
                  'Answer: ${widget.question.answer == 'true' ? 'a. True' : 'b. False'}'),
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
                        Flexible(
                          child: Text(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .merge(const TextStyle(
                                    color: Color(0xff909090),
                                  )),
                              '${widget.index + 1}. ${widget.question.question}'),
                        ),
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
                              onPressed: () {
                                displayDeleteDialog(context, widget.index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .merge(const TextStyle(
                              color: Color(0xfff69036),
                            )),
                        'Answer: ${widget.question.answer}'),
                  ],
                )))
      ],
    );
  }
}
