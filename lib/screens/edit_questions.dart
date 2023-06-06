import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/providers/edit_questions_provider.dart';
import 'package:quizpix/widgets/edit_dialog.dart';
import 'package:quizpix/widgets/edit_question_item.dart';

class EditQuestions extends StatefulWidget {
  const EditQuestions(
      {super.key, required this.questions, required this.onPop});

  final List<Question> questions;
  final Function(List<Question>) onPop;

  @override
  State<EditQuestions> createState() => _EditQuestionsState();
}

class _EditQuestionsState extends State<EditQuestions> {
  Future<dynamic> displayAddDialog(
    BuildContext context,
    List<Question> tempQuestions,
    EditQuestionsProvider editProvider,
  ) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return EditDialog(
            index: tempQuestions.length,
            question: Question('', tempQuestions[0].quiz, 'multiple_choice', '',
                '', ['', '', '', '']),
            type: 'add',
            updateType: (String x) {},
            editProvider: editProvider,
          );
        });
  }

  // void updateTemp(Question? newQuestion, int index) {
  //   setState(() {
  //     // if (newQuestion == null) {
  //     //   tempQuestions.removeAt(index);
  //     // } else if (index == tempQuestions.length) {
  //     //   tempQuestions.add(newQuestion);
  //     // } else {
  //     //   tempQuestions[index] = newQuestion;
  //     // }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditQuestionsProvider()..initTemp(widget.questions),
      child: Scaffold(
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
                          child: Consumer<EditQuestionsProvider>(
                            builder: (context, value, child) {
                              return TextButton.icon(
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
                                onPressed: () {
                                  Navigator.pop(context);
                                  widget.onPop(value.tempQuestions);
                                },
                              );
                            },
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
                      child: Consumer<EditQuestionsProvider>(
                        builder: (context, value, child) {
                          final tempQuestions = value.tempQuestions;
                          if (tempQuestions.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: tempQuestions.length,
                              itemBuilder: (context, index) {
                                return EditQuestionItem(
                                  index: index,
                                  question: tempQuestions[index],
                                );
                              },
                            );
                          }
                          return const Text(
                            "There are no questions to display",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xfff69036),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Consumer<EditQuestionsProvider>(
            builder: (context, value, child) {
              final tempQuestions = value.tempQuestions;
              return FloatingActionButton.extended(
                onPressed: () {
                  displayAddDialog(context, tempQuestions, value);
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
              );
            },
          )),
    );
  }
}
