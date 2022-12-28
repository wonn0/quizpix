import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/widgets/edit_dialog.dart';
import 'package:quizpix/widgets/edit_question_item.dart';

class EditQuestions extends StatefulWidget {
  const EditQuestions({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<EditQuestions> createState() => _EditQuestionsState();
}

class _EditQuestionsState extends State<EditQuestions> {
  final List<Question> tempQuestions = <Question>[];
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final TextEditingController choiceAController = TextEditingController();
  final TextEditingController choiceBController = TextEditingController();
  final TextEditingController choiceCController = TextEditingController();
  final TextEditingController choiceDController = TextEditingController();

  @override
  void initState() {
    super.initState();

    tempQuestions.addAll(widget.questions);
  }

  Future<dynamic> displayAddDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return EditDialog(
            index: tempQuestions.length,
            type: 1,
            question: "",
            answer: "",
            choices: const ['', '', '', ''],
            questionController: questionController,
            answerController: answerController,
            choiceAController: choiceAController,
            choiceBController: choiceBController,
            choiceCController: choiceCController,
            choiceDController: choiceDController,
            updateTemp: updateTemp,
            updateType: (int x) {},
          );
        });
  }

  void updateTemp(Question? newQuestion, int index) {
    setState(() {
      if (newQuestion == null) {
        tempQuestions.removeAt(index);
      } else if (index == tempQuestions.length) {
        tempQuestions.add(newQuestion);
      } else {
        tempQuestions[index] = newQuestion;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (tempQuestions.isNotEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xfffafafa),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 0.0, right: 0.0, bottom: 0.0),
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30.0,
                          color: Color(0xff6d5271),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 16.0, right: 20.0, bottom: 0.0),
                        child: TextButton.icon(
                          icon: const Icon(
                            Icons.save_outlined,
                            size: 30.0,
                            color: Color(0xfff69036),
                          ),
                          label: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xfff69036),
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0, bottom: 20.0),
                    child: const Text(
                      "Edit Questions",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff69036),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 0.0, right: 20.0, bottom: 60.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tempQuestions.length,
                        itemBuilder: (context, index) {
                          return EditQuestionItem(
                            index: index,
                            type: tempQuestions[index].type,
                            question: tempQuestions[index].question,
                            answer: tempQuestions[index].answer,
                            choices: tempQuestions[index].choices!,
                            updateTemp: updateTemp,
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            displayAddDialog(context);
          },
          label: const Text(
            'Add Question',
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 1.0,
            ),
          ),
          icon: const Icon(Icons.add),
          backgroundColor: const Color(0xfff69036),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfffafafa),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 0.0, right: 0.0, bottom: 0.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Color(0xff6d5271),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 16.0, right: 20.0, bottom: 0.0),
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.save_outlined,
                          size: 30.0,
                          color: Color(0xfff69036),
                        ),
                        label: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xfff69036),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 8.0, right: 20.0, bottom: 20.0),
                  child: const Text(
                    "Edit Questions",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff69036),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 0.0, right: 20.0, bottom: 60.0),
                  child: Text(
                    "There are no questions to display",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff69036),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          displayAddDialog(context);
        },
        label: const Text(
          'Add Question',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xfff69036),
      ),
    );
  }
}
