import 'package:flutter/material.dart';
import 'package:quizpix/screens/quiz_generated.dart';
import 'package:quizpix/screens/view_quiz.dart';
import 'package:quizpix/widgets/q_button.dart';
//samples
import 'package:quizpix/samples/items.dart';
import 'package:quizpix/samples/questions.dart';

class PlayQuiz extends StatefulWidget {
  const PlayQuiz({super.key});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: SafeArea(
            child: Column(children: [
          Stack(
            children: [
              const Image(
                image: AssetImage('assets/images/play_screen.png'),
              ),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QuizGenerated()));
                },
              ),
            ],
          ),
          const Spacer(flex: 1),
          Row(
            children: [
              const Spacer(flex: 1),
              Container(
                width: 150,
                height: 120,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.0,
                      children: [
                        Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.merge(const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                )),
                            "True"),
                      ],
                    )),
              ),
              const Spacer(flex: 1),
              Container(
                width: 150,
                height: 120,
                
                child: ElevatedButton(
                    onPressed: () {},
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.0,
                      children: [
                        Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.merge(const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                )),
                            "False"),
                      ],
                    )),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ])));
  }
}
