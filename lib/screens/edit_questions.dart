import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/widgets/edit_question_item.dart';

class EditQuestions extends StatefulWidget {
  const EditQuestions({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<EditQuestions> createState() => _EditQuestionsState();
}

class _EditQuestionsState extends State<EditQuestions> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
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
                    IconButton(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 16.0, right: 28.0, bottom: 0.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.save_outlined,
                        size: 32.0,
                        color: Color(0xfff69036),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 28.0, right: 20.0, bottom: 20.0),
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
                        left: 20.0, top: 0.0, right: 20.0, bottom: 36.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.questions.length,
                      itemBuilder: (context, index) {
                        return EditQuestionItem(
                          index: index,
                          type: widget.questions[index].type,
                          question: widget.questions[index].question,
                          answer: widget.questions[index].answer,
                          choices: widget.questions[index].choices!,
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
