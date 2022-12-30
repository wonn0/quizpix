import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';
//screens
import 'package:quizpix/screens/play_question.dart';
import 'package:quizpix/screens/result_screen.dart';

class GameController extends StatefulWidget {
  const GameController({
    super.key,
    required this.questions,
  });

  final List<Question> questions;

  @override
  State<GameController> createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController> {
  int currentIndex = 0;
  int currentScore = 0;
  bool isDone = false;
  final List<Question> randQuestions = <Question>[];
  final List<String> answers = <String>[];
  final double passPercent = 0.6;

  @override
  void initState() {
    super.initState();

    randQuestions.addAll(widget.questions);
    randQuestions.shuffle();
  }

  void handleAnswer(String userAnswer, String correctAnswer) {
    if (userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase()) {
      setState(() {
        if (currentIndex + 1 != widget.questions.length) {
          currentIndex += 1;
        } else {
          isDone = true;
        }
        currentScore += 1;
        answers.add(userAnswer);
      });
    } else {
      setState(() {
        if (currentIndex + 1 != widget.questions.length) {
          currentIndex += 1;
        } else {
          isDone = true;
        }
        answers.add(userAnswer);
      });
    }
    if (isDone) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            isWin: currentScore >= widget.questions.length * passPercent
                ? true
                : false,
            total: widget.questions.length,
            score: currentScore,
            questions: widget.questions,
            randQuestions: randQuestions,
            answers: answers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlayQuestion(
      index: currentIndex,
      score: currentScore,
      total: randQuestions.length,
      type: randQuestions[currentIndex].type,
      question: randQuestions[currentIndex].question,
      answer: randQuestions[currentIndex].answer,
      choices: randQuestions[currentIndex].choices!,
      onAnswer: handleAnswer,
    );
  }
}
