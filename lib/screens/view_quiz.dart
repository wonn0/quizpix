import 'package:flutter/material.dart';
import 'package:quizpix/screens/edit_questions.dart';
import 'package:quizpix/screens/game_controller.dart';
import 'package:quizpix/screens/play_question.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_icon_button.dart';
import 'package:quizpix/widgets/question_list.dart';
import 'package:quizpix/models/question.dart';

class ViewQuiz extends StatefulWidget {
  const ViewQuiz(
      {super.key,
      required this.author,
      required this.title,
      required this.questions});

  final String author;
  final String title;
  final List<Question> questions;

  @override
  State<ViewQuiz> createState() => _ViewQuizState();
}

class _ViewQuizState extends State<ViewQuiz> {
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
                const SizedBox(height: 20.0),
                Container(
                  height: 160.0,
                  width: 160.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.asset('assets/images/book1.jpg'),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff69036),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    "Quiz Maker: ${widget.author}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff6d5271),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: QButton(
                    label: "Play Quiz",
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GameController(
                            questions: widget.questions,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.play_circle_outlined,
                      size: 30.0,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: QButton(
                    label: "Share Quiz",
                    onPress: () {},
                    icon: const Icon(
                      Icons.share,
                      size: 30.0,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Questions",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xfff69036),
                        ),
                      ),
                      Row(
                        children: [
                          QIconButton(
                            onPress: () {},
                            icon: Icons.download,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          QIconButton(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditQuestions(
                                      questions: widget.questions),
                                ),
                              );
                            },
                            icon: Icons.edit,
                          ),
                        ],
                      ),
                    ],
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
