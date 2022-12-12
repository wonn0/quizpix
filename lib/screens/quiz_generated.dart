import 'package:flutter/material.dart';
import 'package:quizpix/samples/answers.dart';
import 'package:quizpix/screens/view_quiz.dart';
import 'package:quizpix/screens/view_results.dart';
import 'package:quizpix/widgets/q_button.dart';
//samples
import 'package:quizpix/samples/items.dart';
import 'package:quizpix/samples/questions.dart';

class QuizGenerated extends StatefulWidget {
  const QuizGenerated({super.key});

  @override
  State<QuizGenerated> createState() => _QuizGeneratedState();
}

class _QuizGeneratedState extends State<QuizGenerated> {
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
                children: [
                  const Expanded(
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
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80.0, 80.0),
                      backgroundColor: const Color(0xfff69036),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.share,
                      size: 40.0,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              const Image(
                image: AssetImage('assets/images/user1.jpg'),
              ),
              const Spacer(flex: 1),
              Column(
                children: [
                  QButton(
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewQuiz(
                              author: items[0].author,
                              title: items[0].title,
                              questions: questions)));
                    },
                    label: 'View Quiz',
                    icon: const Icon(Icons.visibility_outlined),
                  ),
                  const SizedBox(height: 16.0),
                  QButton(
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewResults(
                              questions: questions, answers: answers)));
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
