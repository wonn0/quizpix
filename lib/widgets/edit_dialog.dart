import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/providers/edit_questions_provider.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({
    super.key,
    required this.index,
    required this.question,
    required this.type,
    required this.updateType,
    required this.editProvider,
  });

  final int index;
  final Question question;
  final String type;
  final Function(String) updateType;
  final EditQuestionsProvider editProvider;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  String type = 'multiple_choice';
  int? answerInd = 0;
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
    questionController.text = widget.question.question;
    answerController.text = widget.question.answer;
    if (widget.question.type == 'multiple_choice') {
      answerInd = widget.question.choices!
          .indexWhere((choice) => choice == widget.question.answer);
      choiceAController.text = widget.question.choices![0];
      choiceBController.text = widget.question.choices![1];
      choiceCController.text = widget.question.choices![2];
      choiceDController.text = widget.question.choices![3];
    } else if (widget.question.type == 'true_or_false') {
      answerInd = widget.question.answer == 'false' ? 0 : 1;
    }
  }

  bool validateInput() {
    if (type == 'multiple_choice') {
      if ((widget.question.type == type) &&
          (questionController.text.trim() == widget.question.question) &&
          (choiceAController.text.trim() == widget.question.choices![0]) &&
          (choiceBController.text.trim() == widget.question.choices![1]) &&
          (choiceCController.text.trim() == widget.question.choices![2]) &&
          (choiceDController.text.trim() == widget.question.choices![3]) &&
          (answerInd ==
              widget.question.choices!
                  .indexWhere((choice) => choice == widget.question.answer))) {
        return false;
      }
      if (questionController.text.trim().isEmpty ||
          choiceAController.text.trim().isEmpty ||
          choiceBController.text.trim().isEmpty ||
          choiceCController.text.trim().isEmpty ||
          choiceDController.text.trim().isEmpty) {
        return false;
      }
      if ((choiceAController.text.trim() == choiceBController.text.trim()) ||
          (choiceAController.text.trim() == choiceCController.text.trim()) ||
          (choiceAController.text.trim() == choiceDController.text.trim()) ||
          (choiceBController.text.trim() == choiceCController.text.trim()) ||
          (choiceBController.text.trim() == choiceDController.text.trim()) ||
          (choiceCController.text.trim() == choiceDController.text.trim())) {
        return false;
      }
    } else if (type == 'true_or_false') {
      int initAnswerInd = widget.question.answer == 'true' ? 1 : 0;
      if (questionController.text.trim().isEmpty ||
          (questionController.text.trim() == widget.question.question &&
              answerInd == initAnswerInd &&
              widget.question.type == type)) {
        return false;
      }
      if (answerInd != 0 && answerInd != 1) {
        return false;
      }
    } else {
      if (questionController.text.trim().isEmpty ||
          answerController.text.trim().isEmpty) {
        return false;
      }
      if ((widget.question.type == type) &&
          (questionController.text.trim() == widget.question.question) &&
          (answerController.text.trim() == widget.question.answer)) {
        return false;
      }
    }

    return true;
  }

  String getNewAnswer() {
    if (type == 'multiple_choice') {
      switch (answerInd) {
        case 0:
          return choiceAController.text.trim();
        case 1:
          return choiceBController.text.trim();
        case 2:
          return choiceCController.text.trim();
        case 3:
          return choiceDController.text.trim();
        default:
          return choiceAController.text.trim();
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      contentPadding: const EdgeInsets.only(
          left: 20.0, top: 20.0, right: 20.0, bottom: 8.0),
      actionsPadding: const EdgeInsets.only(right: 20.0, bottom: 8.0),
      title: Text(
        widget.type == 'add' ? 'New Question' : 'Edit Question',
        style: const TextStyle(
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
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(bottom: 16.0),
                child: const Text(
                  'Type',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xfff69036),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                          value: 'multiple_choice',
                          groupValue: type,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          }),
                      const SizedBox(width: 8.0),
                      const Text('MC',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6d5271),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                          value: 'true_or_false',
                          groupValue: type,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          }),
                      const SizedBox(width: 8.0),
                      const Text('T/F',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6d5271),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                          value: 'identification',
                          groupValue: type,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          }),
                      const SizedBox(width: 8.0),
                      const Text('FITB',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff6d5271),
                          )),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: const Text(
                  'Question',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xfff69036),
                  ),
                ),
              ),
              TextField(
                controller: questionController,
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
                  labelText: 'Question',
                  hintText: 'Please enter a valid question',
                  labelStyle: TextStyle(
                    color: Color(0xff909090),
                  ),
                  hintStyle: TextStyle(
                    color: Color(0xff909090),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  type == 'identification' ? 'Answer' : 'Choices & Answer',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xfff69036),
                  ),
                ),
              ),
              if (type == 'multiple_choice') ...[
                TextField(
                  controller: choiceAController,
                  style: const TextStyle(
                    color: Color(0xff6d5271),
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    icon: IconButton(
                      onPressed: null,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Radio<int>(
                          value: 0,
                          groupValue: answerInd,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          onChanged: (value) {
                            setState(() {
                              answerInd = value;
                            });
                          }),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    filled: false,
                    labelText: 'Choice A',
                    hintText: 'Please enter a valid choice',
                    labelStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: choiceBController,
                  style: const TextStyle(
                    color: Color(0xff6d5271),
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    icon: IconButton(
                      onPressed: null,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Radio<int>(
                          value: 1,
                          groupValue: answerInd,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          onChanged: (value) {
                            setState(() {
                              answerInd = value;
                            });
                          }),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    filled: false,
                    labelText: 'Choice B',
                    hintText: 'Please enter a valid choice',
                    labelStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: choiceCController,
                  style: const TextStyle(
                    color: Color(0xff6d5271),
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    icon: IconButton(
                      onPressed: null,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Radio<int>(
                          value: 2,
                          groupValue: answerInd,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          onChanged: (value) {
                            setState(() {
                              answerInd = value;
                            });
                          }),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    filled: false,
                    labelText: 'Choice C',
                    hintText: 'Please enter a valid choice',
                    labelStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: choiceDController,
                  style: const TextStyle(
                    color: Color(0xff6d5271),
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    icon: IconButton(
                      onPressed: null,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Radio<int>(
                          value: 3,
                          groupValue: answerInd,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          onChanged: (value) {
                            setState(() {
                              answerInd = value;
                            });
                          }),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6d5271),
                      ),
                    ),
                    filled: false,
                    labelText: 'Choice D',
                    hintText: 'Please enter a valid choice',
                    labelStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff909090),
                    ),
                  ),
                ),
              ] else if (type == 'true_or_false') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: answerInd,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (value) {
                            setState(() {
                              answerInd = value;
                            });
                          },
                        ),
                        const SizedBox(width: 8.0),
                        const Text('True',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff6d5271),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: answerInd,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff6d5271)),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (value) {
                            setState(() {
                              answerInd = value;
                            });
                          },
                        ),
                        const SizedBox(width: 8.0),
                        const Text('False',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff6d5271),
                            )),
                      ],
                    ),
                  ],
                ),
              ] else ...[
                TextField(
                  controller: answerController,
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
                    labelText: 'Answer',
                    hintText: 'Please enter a valid answer',
                    labelStyle: TextStyle(
                      color: Color(0xff909090),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xff909090),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (type == 'multiple_choice' && validateInput()) {
              Question newQuestion = Question(
                widget.question.url,
                widget.question.quiz,
                type,
                questionController.text.trim(),
                getNewAnswer(),
                [
                  choiceAController.text.trim(),
                  choiceBController.text.trim(),
                  choiceCController.text.trim(),
                  choiceDController.text.trim()
                ],
              );
              if (widget.type == 'add') {
                // createQuestion(newQuestion).then((response) {
                //   Navigator.of(context).pop();
                //   widget.updateTemp(newQuestion, widget.index);
                //   if (type != widget.question.type) {
                //     widget.updateType(type);
                //   }
                // });
                widget.editProvider.add(newQuestion);
                Navigator.of(context).pop();
              } else {
                // updateQuestion(newQuestion).then((response) {
                //   Navigator.of(context).pop();
                //   widget.updateTemp(newQuestion, widget.index);
                //   if (type != widget.question.type) {
                //     widget.updateType(type);
                //   }
                // });
                widget.editProvider.update(newQuestion, widget.index);
                Navigator.of(context).pop();
              }
            } else if (type == 'true_or_false' && validateInput()) {
              Question newQuestion = Question(
                widget.question.url,
                widget.question.quiz,
                type,
                questionController.text.trim(),
                answerInd == 1 ? 'true' : 'false',
                [],
              );
              if (widget.type == 'add') {
                // createQuestion(newQuestion).then((response) {
                //   Navigator.of(context).pop();
                //   widget.updateTemp(newQuestion, widget.index);
                //   if (type != widget.question.type) {
                //     widget.updateType(type);
                //   }
                // });
                widget.editProvider.add(newQuestion);
                Navigator.of(context).pop();
              } else {
                // updateQuestion(newQuestion).then((response) {
                //   Navigator.of(context).pop();
                //   widget.updateTemp(newQuestion, widget.index);
                //   if (type != widget.question.type) {
                //     widget.updateType(type);
                //   }
                // });
                widget.editProvider.update(newQuestion, widget.index);
                Navigator.of(context).pop();
              }
            } else if (type == 'identification' && validateInput()) {
              Question newQuestion = Question(
                widget.question.url,
                widget.question.quiz,
                type,
                questionController.text.trim(),
                answerController.text.trim(),
                [],
              );
              if (widget.type == 'add') {
                // createQuestion(newQuestion).then((response) {
                //   Navigator.of(context).pop();
                //   widget.updateTemp(newQuestion, widget.index);
                //   if (type != widget.question.type) {
                //     widget.updateType(type);
                //   }
                // });
                widget.editProvider.add(newQuestion);
                Navigator.of(context).pop();
              } else {
                // updateQuestion(newQuestion).then((response) {
                //   Navigator.of(context).pop();
                //   widget.updateTemp(newQuestion, widget.index);
                //   if (type != widget.question.type) {
                //     widget.updateType(type);
                //   }
                // });
                widget.editProvider.update(newQuestion, widget.index);
                Navigator.of(context).pop();
              }
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(32, 32),
            backgroundColor: const Color(0xfff69036),
            elevation: 4.0,
          ),
          child: const Text('Save', style: TextStyle(fontSize: 16.0)),
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
