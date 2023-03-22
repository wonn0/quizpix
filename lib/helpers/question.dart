import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizpix/widgets/q_toast.dart';

import '../env.sample.dart';
import '../globals/globals.dart';
import '../models/question.dart';

Future<Question> createQuestion(Question question) async {
  // late NavigatorState dialogContext;
  // showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (BuildContext context) {
  //     dialogContext = Navigator.of(context);
  //     return const Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   },
  // );
  print(jsonEncode(<String, dynamic>{
    'quiz': question.quiz,
    'type': question.type,
    'question': question.question,
    'answer': question.answer,
    'choices': question.choices,
  }));
  final response = await http.post(Uri.parse('${Env.URL_PREFIX}/questions/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'quiz': question.quiz,
        'type': question.type,
        'question': question.question,
        'answer': question.answer,
        'choices': question.choices,
      }));
  print(response.body);
  if (response.statusCode == 201) {
    final questionJson = jsonDecode(response.body);
    print(questionJson);
    return Question.fromJson(questionJson);
  } else {
    showQToast("Failed to create question", true);
    throw Exception('Failed to create question.');
  }
}
