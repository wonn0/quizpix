import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizpix/constants/choices.dart';
import 'package:quizpix/providers/edit_questions_provider.dart';
import 'package:quizpix/widgets/edit_dialog.dart';
import 'package:quizpix/models/question.dart';

class EditQuestionItem extends StatefulWidget {
  const EditQuestionItem({
    super.key,
    required this.index,
    required this.question,
  });

  final int index;
  final Question question;

  @override
  State<EditQuestionItem> createState() => _EditQuestionItemState();
}

class _EditQuestionItemState extends State<EditQuestionItem> {
  String type = 'multiple_choice';

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

  Future<dynamic> displayEditDialog(
    BuildContext context,
    EditQuestionsProvider editProvider,
  ) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return EditDialog(
            index: widget.index,
            question: widget.question,
            type: 'edit',
            updateType: updateType,
            editProvider: editProvider,
          );
        });
  }

  Future<dynamic> displayDeleteDialog(
    BuildContext context,
    int index,
    EditQuestionsProvider editProvider,
  ) async {
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
                  // await deleteQuestion(widget.question);
                  editProvider.delete(index);
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
                            displayEditDialog(
                              context,
                              context.read<EditQuestionsProvider>(),
                            );
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
                            displayDeleteDialog(
                              context,
                              widget.index,
                              context.read<EditQuestionsProvider>(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (type == 'multiple_choice') ...[
                  //choices
                  for (var item in widget.question.choices!) ...[
                    Text(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .merge(const TextStyle(
                            color: Color(0xff909090),
                          )),
                      '${choicesMap[widget.question.choices!.indexOf(item) + 1]}. ${widget.question.choices![widget.question.choices!.indexOf(item)]}',
                    )
                  ],

                  Text(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .merge(const TextStyle(
                          color: Color(0xfff69036),
                        )),
                    'Answer: ${choicesMap[widget.question.choices!.indexWhere((choice) => choice == widget.question.answer) + 1]}. ${widget.question.answer}',
                  ),
                ] else if (type == 'true_or_false') ...[
                  Text(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .merge(const TextStyle(
                          color: Color(0xff909090),
                        )),
                    'a. True',
                  ),
                  Text(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .merge(const TextStyle(
                          color: Color(0xff909090),
                        )),
                    'b. False',
                  ),
                  Text(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .merge(const TextStyle(
                          color: Color(0xfff69036),
                        )),
                    'Answer: ${widget.question.answer == 'true' ? 'a. True' : 'b. False'}',
                  ),
                ] else ...[
                  Text(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .merge(const TextStyle(
                          color: Color(0xfff69036),
                        )),
                    'Answer: ${widget.question.answer}',
                  ),
                ],
              ],
            ),
          ),
        )
      ],
    );
  }
}
