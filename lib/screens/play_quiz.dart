import 'package:flutter/material.dart';
import 'package:quizpix/screens/quiz_generated.dart';
import 'package:quizpix/screens/result_screen.dart';
import 'package:quizpix/screens/view_quiz.dart';
import 'package:quizpix/widgets/item_dialog.dart';
import 'package:quizpix/widgets/q_button.dart';
//samples
import 'package:quizpix/samples/items.dart';
import 'package:quizpix/samples/questions.dart';

class PlayQuiz extends StatefulWidget {
  const PlayQuiz({super.key});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

Future<dynamic> displayItemDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemDialog(
          boQuantity: 1,
          reQuantity: 1,
          frQuantity: 1,
        );
      });
}

class _PlayQuizState extends State<PlayQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                const Image(
                  image: AssetImage('assets/images/play_screen.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 16.0, right: 20.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30.0,
                          color: Color(0xfff69036),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          displayItemDialog(context);
                        },
                        child: SizedBox(
                            height: 30.0,
                            child: Image.asset('assets/images/potion_red.png',
                                fit: BoxFit.fitHeight)),
                      ),
                    ],
                  ),
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                  result: 'win',
                                  total: 20,
                                  score: 15,
                                )));
                      },
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                  result: 'lose',
                                  total: 20,
                                  score: 10,
                                )));
                      },
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
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
