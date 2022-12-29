import 'package:flutter/material.dart';
import 'package:quizpix/widgets/answer_dialog.dart';
import 'package:quizpix/widgets/game_button.dart';
import 'package:quizpix/widgets/item_dialog.dart';

class PlayQuestion extends StatefulWidget {
  const PlayQuestion({super.key, required this.type});

  final int type;

  @override
  State<PlayQuestion> createState() => _PlayQuestionState();
}

class _PlayQuestionState extends State<PlayQuestion> {
  final TextEditingController answerController = TextEditingController();

  Future<dynamic> displayItemDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemDialog(
          boQuantity: 1,
          reQuantity: 1,
          frQuantity: 1,
        );
      },
    );
  }

  Future<dynamic> displayAnswerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnswerDialog(answerController: answerController);
      },
    );
  }

  Widget getAnswerArea() {
    if (widget.type == 1) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GameButton(isMC: true, label: "A.", onPress: () {}),
                    const SizedBox(height: 8.0),
                    GameButton(isMC: true, label: "C.", onPress: () {}),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GameButton(isMC: true, label: "B.", onPress: () {}),
                    const SizedBox(height: 8.0),
                    GameButton(isMC: true, label: "D.", onPress: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else if (widget.type == 2) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GameButton(label: "True", onPress: () {}),
              const SizedBox(width: 8.0),
              GameButton(label: "False", onPress: () {}),
            ],
          ),
        ),
      );
    }
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameButton(
              isAnswer: true,
              label: "Answer",
              onPress: () {
                displayAnswerDialog(context);
              },
            ),
            const SizedBox(width: 8.0),
            GameButton(label: "Submit", onPress: () {}),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/game_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
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
                                child: Image.asset(
                                    'assets/images/potion_red.png',
                                    fit: BoxFit.fitHeight)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 24.0, right: 20.0),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 24.0),
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 28.0,
                              right: 20.0,
                              bottom: 20.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: const Color(0xfff5f5f5),
                            ),
                            child: Text(
                              "The sun rises at night",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: const Color(0xff6d5271),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 24.0),
                            padding: const EdgeInsets.only(
                              left: 24.0,
                              top: 12.0,
                              right: 24.0,
                              bottom: 12.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: const Color(0xff6d5271),
                            ),
                            child: Text(
                              "Question 1 / 20",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 56.0,
                            child: Image.asset(
                                'assets/images/player/player_attack1_00.png',
                                fit: BoxFit.fitHeight),
                          ),
                          SizedBox(
                            height: 116.0,
                            child: Image.asset(
                                'assets/images/enemy/enemy_idle_00.png',
                                fit: BoxFit.fitHeight),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/images/grass_tile.png"),
                                repeat: ImageRepeat.repeatX,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            getAnswerArea(),
          ],
        ),
      ),
    );
  }
}
