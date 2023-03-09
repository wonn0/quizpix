import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizpix/widgets/q_toast.dart';

import '../env.sample.dart';
import '../globals/globals.dart';
import '../models/quiz.dart';

Future<Quiz> createQuiz(BuildContext context, Quiz quiz) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('${Env.URL_PREFIX}/quizzes/'),
  );

  request.fields['user'] = localDetails.url!;
  request.fields['image'] = '';
  request.fields['title'] = quiz.title;

  request.headers.addAll(<String, String>{
    'Content-Type': 'multipart/form-data',
  });

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

  final response = await http.Response.fromStream(await request.send());
  print(jsonDecode(response.body));
  if (response.statusCode == 201) {
    final quizJson = jsonDecode(response.body);
    dialogContext.pop();
    return Quiz.fromJson(quizJson);
  } else {
    dialogContext.pop();
    throw Exception('Failed to update quiz.');
  }
}
