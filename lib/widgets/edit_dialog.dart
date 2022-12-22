import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';

class EditDialog extends StatefulWidget {
  const EditDialog(
      {super.key,
      required this.index,
      required this.type,
      required this.question,
      required this.answer,
      this.choices,
      required this.updateTemp,
      required this.questionController,
      this.answerController,
      this.choiceAController,
      this.choiceBController,
      this.choiceCController,
      this.choiceDController});

  final int index;
  final int type;
  final String question;
  final String answer;
  final List<String>? choices;
  final Function(Question, int) updateTemp;
  final TextEditingController questionController;
  final TextEditingController? answerController;
  final TextEditingController? choiceAController;
  final TextEditingController? choiceBController;
  final TextEditingController? choiceCController;
  final TextEditingController? choiceDController;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  int? answerInd = 0;

  @override
  void initState() {
    super.initState();

    widget.questionController.text = widget.question;
    if (widget.type == 1) {
      answerInd =
          widget.choices!.indexWhere((choice) => choice == widget.answer);
      widget.choiceAController!.text = widget.choices![0];
      widget.choiceBController!.text = widget.choices![1];
      widget.choiceCController!.text = widget.choices![2];
      widget.choiceDController!.text = widget.choices![3];
    } else if (widget.type == 2) {
      answerInd = widget.answer == 'true' ? 1 : 0;
    }
  }

  bool validateInput() {
    if (widget.type == 1) {
      if ((widget.questionController.text.trim() == widget.question) &&
          (widget.choiceAController!.text.trim() == widget.choices![0]) &&
          (widget.choiceBController!.text.trim() == widget.choices![1]) &&
          (widget.choiceCController!.text.trim() == widget.choices![2]) &&
          (widget.choiceDController!.text.trim() == widget.choices![3]) &&
          (answerInd ==
              widget.choices!
                  .indexWhere((choice) => choice == widget.answer))) {
        return false;
      }
      if (widget.questionController.text.trim().isEmpty ||
          widget.choiceAController!.text.trim().isEmpty ||
          widget.choiceBController!.text.trim().isEmpty ||
          widget.choiceCController!.text.trim().isEmpty ||
          widget.choiceDController!.text.trim().isEmpty) {
        return false;
      }
      if ((widget.choiceAController!.text.trim() ==
              widget.choiceBController!.text.trim()) ||
          (widget.choiceAController!.text.trim() ==
              widget.choiceCController!.text.trim()) ||
          (widget.choiceAController!.text.trim() ==
              widget.choiceDController!.text.trim()) ||
          (widget.choiceBController!.text.trim() ==
              widget.choiceCController!.text.trim()) ||
          (widget.choiceBController!.text.trim() ==
              widget.choiceDController!.text.trim()) ||
          (widget.choiceCController!.text.trim() ==
              widget.choiceDController!.text.trim())) {
        return false;
      }
    } else if (widget.type == 2) {
      int initAnswerInd = widget.answer == 'true' ? 1 : 0;
      if (widget.questionController.text.trim().isEmpty ||
          (widget.questionController.text.trim() == widget.question &&
              answerInd == initAnswerInd)) {
        return false;
      }
    }

    return true;
  }

  String getNewAnswer() {
    if (widget.type == 1) {
      switch (answerInd) {
        case 0:
          return widget.choiceAController!.text;
        case 1:
          return widget.choiceBController!.text;
        case 2:
          return widget.choiceCController!.text;
        case 3:
          return widget.choiceDController!.text;
        default:
          return widget.choiceAController!.text;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 1) {
      return AlertDialog(
        titlePadding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        contentPadding: const EdgeInsets.only(
            left: 20.0, top: 20.0, right: 20.0, bottom: 8.0),
        actionsPadding: const EdgeInsets.only(right: 20.0, bottom: 8.0),
        title: const Text(
          'Edit Question',
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
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(bottom: 16.0),
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
                  controller: widget.questionController,
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
                  child: const Text(
                    'Choices & Answer',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xfff69036),
                    ),
                  ),
                ),
                TextField(
                  controller: widget.choiceAController,
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
                  controller: widget.choiceBController,
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
                  controller: widget.choiceCController,
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
                  controller: widget.choiceDController,
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
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (validateInput()) {
                Question newQuestion = Question(
                  widget.type,
                  widget.questionController.text,
                  getNewAnswer(),
                  [
                    widget.choiceAController!.text,
                    widget.choiceBController!.text,
                    widget.choiceCController!.text,
                    widget.choiceDController!.text
                  ],
                );
                Navigator.of(context).pop();
                widget.updateTemp(newQuestion, widget.index);
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
    } else if (widget.type == 2) {
      return AlertDialog(
        titlePadding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        contentPadding: const EdgeInsets.only(
            left: 20.0, top: 20.0, right: 20.0, bottom: 8.0),
        actionsPadding: const EdgeInsets.only(right: 20.0, bottom: 8.0),
        title: const Text(
          'Edit Question',
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
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(bottom: 16.0),
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
                  controller: widget.questionController,
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
                  child: const Text(
                    'Choices & Answer',
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
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (validateInput()) {
                Question newQuestion = Question(
                  widget.type,
                  widget.questionController.text,
                  answerInd == 1 ? 'true' : 'false',
                  [],
                );
                Navigator.of(context).pop();
                widget.updateTemp(newQuestion, widget.index);
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
    return AlertDialog(
      titlePadding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      contentPadding:
          EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 8.0),
      actionsPadding: EdgeInsets.only(right: 20.0, bottom: 8.0),
      title: Text(
        'Add To-Do',
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Colors.teal,
        ),
      ),
      content: TextField(
        controller: widget.answerController,
        style: TextStyle(
          color: Colors.teal,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: 'New To-Do',
          hintText: 'Enter To-Do here',
          labelStyle: TextStyle(
            color: Colors.teal[200],
          ),
          hintStyle: TextStyle(
            color: Colors.teal[200],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(32, 32),
            backgroundColor: const Color(0xfff69036),
            elevation: 6.0,
          ),
          child: const Text('Save'),
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
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
