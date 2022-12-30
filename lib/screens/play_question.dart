import 'package:flutter/material.dart';
import 'package:quizpix/widgets/answer_dialog.dart';
import 'package:quizpix/widgets/game_button.dart';
import 'package:quizpix/widgets/health_bar.dart';
import 'package:quizpix/widgets/item_dialog.dart';

class PlayQuestion extends StatefulWidget {
  const PlayQuestion({
    super.key,
    required this.index,
    required this.score,
    required this.total,
    required this.type,
    required this.question,
    required this.answer,
    required this.choices,
    required this.onAnswer,
  });

  final int index;
  final int score;
  final int total;
  final int type;
  final String question;
  final String answer;
  final List<String> choices;
  final Function(String, String) onAnswer;

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

  Future<dynamic> displayAnswerDialog(
    BuildContext context,
    Function(String, String) onAnswer,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnswerDialog(
          answerController: answerController,
          correctAnswer: widget.answer,
          onAnswer: onAnswer,
        );
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
                    GameButton(
                      isMC: true,
                      label: "A. ${widget.choices[0]}",
                      onPress: () {
                        widget.onAnswer(widget.choices[0], widget.answer);
                      },
                    ),
                    const SizedBox(height: 8.0),
                    GameButton(
                      isMC: true,
                      label: "C. ${widget.choices[2]}",
                      onPress: () {
                        widget.onAnswer(widget.choices[2], widget.answer);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GameButton(
                      isMC: true,
                      label: "B. ${widget.choices[1]}",
                      onPress: () {
                        widget.onAnswer(widget.choices[1], widget.answer);
                      },
                    ),
                    const SizedBox(height: 8.0),
                    GameButton(
                      isMC: true,
                      label: "D. ${widget.choices[3]}",
                      onPress: () {
                        widget.onAnswer(widget.choices[3], widget.answer);
                      },
                    ),
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
              GameButton(
                label: "True",
                onPress: () {
                  widget.onAnswer("true", widget.answer);
                },
              ),
              const SizedBox(width: 8.0),
              GameButton(
                label: "False",
                onPress: () {
                  widget.onAnswer("false", widget.answer);
                },
              ),
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
                displayAnswerDialog(context, widget.onAnswer);
              },
            ),
            const SizedBox(width: 8.0),
            GameButton(
              label: "Skip",
              onPress: () {
                widget.onAnswer("", widget.answer);
              },
            ),
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
                              widget.question,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: Color(0xff6d5271),
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
                              "Question ${widget.index + 1} / ${widget.total}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: Color(0xffffffff),
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
                          Column(
                            children: [
                              HealthBar(
                                healthFactor: (widget.index - widget.score) /
                                    widget.total,
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                height: 56.0,
                                child: Image.asset(
                                    'assets/images/player/player_attack1_00.png',
                                    fit: BoxFit.fitHeight),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              HealthBar(
                                healthFactor: widget.score / widget.total,
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                height: 116.0,
                                child: Image.asset(
                                  'assets/images/enemy/enemy_idle_00.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
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