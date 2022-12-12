import 'package:flutter/material.dart';
import 'package:quizpix/widgets/question_list.dart';
import 'package:quizpix/models/question.dart';

class ViewResults extends StatefulWidget {
  const ViewResults({
    super.key,
    required this.questions,
    required this.answers,
  });

  final List<Question> questions;
  final List<String> answers;

  @override
  State<ViewResults> createState() => _ViewResultsState();
}

class _ViewResultsState extends State<ViewResults> {
  @override
  Widget build(BuildContext context) {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 16.0, right: 0.0, bottom: 0.0),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 28.0, right: 20.0, bottom: 28.0),
                  child: Text(
                    "Review Your Answers",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff69036),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 12.0, right: 20.0, bottom: 32.0),
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 12.0, right: 20.0, bottom: 20.0),
                      constraints: const BoxConstraints(
                        minHeight: 200.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: const Color(0xfff69036),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: QuestionList(
                        questions: widget.questions,
                        answers: widget.answers,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
