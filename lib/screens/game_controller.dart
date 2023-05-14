import 'package:flutter/material.dart';
import 'package:quizpix/globals/globals.dart';
import 'package:quizpix/helpers/user.dart';
//screens
import 'package:quizpix/screens/play_question.dart';
import 'package:quizpix/screens/result_screen.dart';

import '../models/user.dart';
import '../models/question.dart';

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
  List<int> items = <int>[999, 999, 999];
  final double passPercent = 0.6;

  @override
  void initState() {
    super.initState();

    randQuestions.addAll(widget.questions);
    randQuestions.shuffle();
  }

  void handleBonus() {
    setState(() {
      currentScore += 1;
      List<int> newItems = List.from(items);
      newItems[0] = newItems[0] - 1;
      items = List.from(newItems);
    });
    Navigator.of(context).pop();
  }

  void handleRedo() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex -= 1;
      }
      List<int> newItems = List.from(items);
      newItems[1] = newItems[1] - 1;
      items = List.from(newItems);
    });

    Navigator.of(context).pop();
  }

  void handlePass(String correctAnswer) {
    setState(() {
      currentScore += 1;
      currentIndex += 1;
      List<int> newItems = List.from(items);
      newItems[2] = newItems[2] - 1;
      items = List.from(newItems);
      answers.add(correctAnswer);
    });
    if (currentIndex >= widget.questions.length) {
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
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> handleAnswer(String userAnswer, String correctAnswer) async {
    setState(() {
      if (currentIndex + 1 <= answers.length) {
        answers[currentIndex] = userAnswer;
        currentIndex += 1;
      } else if (currentIndex + 1 != widget.questions.length) {
        currentIndex += 1;
        answers.add(userAnswer);
      } else {
        isDone = true;
        answers.add(userAnswer);
      }
      if (userAnswer.trim().toLowerCase() ==
          correctAnswer.trim().toLowerCase()) {
        currentScore += 1;
      }
    });
    if (isDone) {
      User temp = User(
          localDetails.url,
          localDetails.username,
          localDetails.password,
          localDetails.email,
          localDetails.title,
          localDetails.profilePicture,
          true,
          localDetails.quizzesMade,
          localDetails.totalScore + currentScore,
          localDetails.status,
          localDetails.items);
      //update user details
      await updateQuizzesMade(temp);
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
      items: items,
      onAnswer: handleAnswer,
      onBonus: handleBonus,
      onRedo: handleRedo,
      onPass: handlePass,
    );
  }
}
