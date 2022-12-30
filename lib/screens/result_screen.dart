import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/screens/game_controller.dart';
import 'package:quizpix/screens/view_results.dart';
import 'package:quizpix/widgets/q_button.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.isWin,
    required this.total,
    required this.score,
    required this.questions,
    required this.randQuestions,
    required this.answers,
  });

  final bool isWin;
  final int total;
  final int score;
  final List<Question> questions;
  final List<Question> randQuestions;
  final List<String> answers;

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
              widget.isWin == true ? "Victory!" : "Defeat...",
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
                image: AssetImage(widget.isWin == true
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
                              questions: widget.randQuestions,
                              answers: widget.answers,
                            )));
                  },
                  label: 'View Results',
                  icon: const Icon(Icons.visibility_outlined),
                ),
                const SizedBox(height: 16.0),
                QButton(
                  onPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameController(
                          questions: widget.questions,
                        ),
                      ),
                    );
                  },
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
