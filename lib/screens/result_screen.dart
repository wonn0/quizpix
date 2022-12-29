import 'package:flutter/material.dart';
import 'package:quizpix/samples/answers.dart';
import 'package:quizpix/screens/play_question.dart';
import 'package:quizpix/screens/view_quiz.dart';
import 'package:quizpix/screens/view_results.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/samples/items.dart';
import 'package:quizpix/samples/questions.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {super.key,
      required this.result,
      required this.total,
      required this.score});

  final String result;
  final int total;
  final int score;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: const BoxDecoration(color: Color(0xfff5f5f5)),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Text(
              widget.result == 'win' ? "Victory!" : "Defeat...",
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w700,
                color: Color(0xfff69036),
              ),
            ),
            const Spacer(flex: 1),
            Stack(children: [
              Image(
                fit: BoxFit.fitHeight,
                image: AssetImage(widget.result == 'win'
                    ? 'assets/images/8601.jpg'
                    : 'assets/images/6397869.jpg'),
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: Container(
                      alignment: Alignment.center,
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${widget.score} / ${widget.total}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffffffff),
                        ),
                      )))
            ]),
            const Spacer(flex: 1),
            Column(
              children: [
                QButton(
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewResults(
                              questions: questions,
                              answers: answers,
                            )));
                  },
                  label: 'View Results',
                  icon: const Icon(Icons.visibility_outlined),
                ),
                const SizedBox(height: 16.0),
                QButton(
                  onPress: () {},
                  label: 'Try Again',
                  icon: const Icon(Icons.replay),
                ),
                const SizedBox(height: 16.0),
                QButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  label: 'Back to Home',
                  icon: const Icon(Icons.home),
                )
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      )),
    );
  }
}
