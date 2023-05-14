import 'package:flutter/material.dart';
import 'package:quizpix/globals/globals.dart';
import 'package:quizpix/helpers/quiz.dart';
import 'package:quizpix/helpers/question.dart';
import 'package:quizpix/screens/view_quiz.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/screens/game_controller.dart';
//samples
import 'package:quizpix/samples/items.dart';
import 'package:quizpix/samples/questions.dart';
import 'package:quizpix/models/quiz.dart';
import 'package:quizpix/models/question.dart';

class QuizGenerated extends StatefulWidget {
  const QuizGenerated({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  State<QuizGenerated> createState() => _QuizGeneratedState();
}

class _QuizGeneratedState extends State<QuizGenerated> {
  Future<List<Question>> fetchQuestions() async {
    try {
      List<Question> result = await getQuizQuestions(widget.quiz);

      return result;
    } catch (e) {
      print('Error fetching questions: $e');
      throw Exception('Failed to get questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(
            color: Color(0xfff5f5f5),
          ),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Your Quiz is ready!",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff69036),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                ],
              ),
              const Spacer(flex: 1),
              const Image(
                image: AssetImage('assets/images/quiz-ready.png'),
              ),
              const Spacer(flex: 1),
              Column(
                children: [
                  QButton(
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewQuiz(
                              quiz: widget.quiz,
                              onPop: () async {
                                quizzes = await getUserQuizzes();
                                setState(() {});
                              })));
                    },
                    label: 'View Quiz',
                    icon: const Icon(Icons.visibility_outlined),
                  ),
                  const SizedBox(height: 16.0),
                  QButton(
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FutureBuilder(
                            future: fetchQuestions(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return GameController(
                                      questions: snapshot.data!);
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      );
                    },
                    label: 'Play Quiz',
                    icon: const Icon(Icons.gamepad_outlined),
                  ),
                  const SizedBox(height: 16.0),
                  QButton(
                    onPress: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    label: 'Back to Scan',
                    icon: const Icon(Icons.camera_enhance_outlined),
                  )
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
