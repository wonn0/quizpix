import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizpix/widgets/q_toast.dart';

import '../env.sample.dart';
import '../globals/globals.dart';
import '../models/question.dart';

Future<Question> createQuestion(
    BuildContext context, Question question, String quizUrl) async {
  late NavigatorState dialogContext;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      dialogContext = Navigator.of(context);
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  final response = await http.post(Uri.parse('${Env.URL_PREFIX}/questions/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'quiz': quizUrl,
        'type': question.type,
        'question': question.question,
        'answer': question.answer,
        'choices': question.choices,
      }));
  if (response.statusCode == 201) {
    final questionJson = jsonDecode(response.body);
    return Question.fromJson(questionJson);
  } else {
    dialogContext.pop();
    showQToast("Failed to create account", true);
    throw Exception('Failed to create user.');
  }
}