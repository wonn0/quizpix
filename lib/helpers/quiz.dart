import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizpix/models/question.dart';
import 'package:quizpix/widgets/q_toast.dart';

import '../env.sample.dart';
import '../globals/globals.dart';
import '../models/quiz.dart';

Future<Quiz> createQuiz() async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('${Env.URL_PREFIX}/quizzes/'),
  );

  request.fields['user'] = localDetails.url!;
  request.fields['image'] = '';
  request.fields['title'] = 'My Quiz';
  request.fields['is_shared'] = 'false';

  request.headers.addAll(<String, String>{
    'Content-Type': 'multipart/form-data',
  });

  final response = await http.Response.fromStream(await request.send());
  print(jsonDecode(response.body));
  if (response.statusCode == 201) {
    final quizJson = jsonDecode(response.body);
    // dialogContext.pop();
    return Quiz.fromJson(quizJson);
  } else {
    // dialogContext.pop();
    throw Exception('Failed to create quiz instance.');
  }
}

Future<List<Quiz>> getUserQuizzes() async {
  RegExp regExp = RegExp(r'users/(\d+)');
  Match? match = regExp.firstMatch(localDetails.url!);
  final response = await http.get(
    Uri.parse('${Env.URL_PREFIX}/quizzes/?user=${match!.group(1)}'),
  );
  print(response.headers);
  print(response.body);
  if (response.statusCode == 200) {
    final quizzesJson = jsonDecode(response.body);
    final List<Quiz> quizzes = quizzesJson
        .map<Quiz>((json) => Quiz.fromJson(json as Map<String, dynamic>))
        .toList();
    return quizzes;
  } else {
    print("Failed to get quizzes with status code ${response.statusCode}");
    showQToast(
        "Failed to get quizzes with status code ${response.statusCode}", true);
    throw Exception('Failed to get quizzes.');
  }
}

Future<List<Quiz>> getSharedQuizzes() async {
  final response = await http.get(
    Uri.parse('${Env.URL_PREFIX}/quizzes/?is_shared=true'),
  );
  print(response.headers);
  print(response.body);
  if (response.statusCode == 200) {
    final quizzesJson = jsonDecode(response.body);
    final List<Quiz> quizzes = quizzesJson
        .map<Quiz>((json) => Quiz.fromJson(json as Map<String, dynamic>))
        .toList();
    return quizzes;
  } else {
    print("Failed to get quizzes with status code ${response.statusCode}");
    showQToast(
        "Failed to get quizzes with status code ${response.statusCode}", true);
    throw Exception('Failed to get quizzes.');
  }
}

Future<Map<String, dynamic>> getQuestions(
    BuildContext context, String text) async {
  late NavigatorState dialogContext;
  final response = await http.post(Uri.parse(Env.URL_NLP),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "text": text,
      }));
  print(response.headers);
  print(response.body);
  if (response.statusCode == 200) {
    final generatedQuestions = jsonDecode(response.body);
    return generatedQuestions;
  } else {
    // dialogContext.pop();
    print("Failed to create quiz with status code ${response.statusCode}");
    showQToast(
        "Failed to create quiz with status code ${response.statusCode}", true);
    throw Exception('Failed to create quiz.');
  }
}

Future<Quiz> updateQuiz(Quiz quiz) async {
  print(jsonEncode(<String, dynamic>{
    'url': quiz.url,
    'user': quiz.user,
    'username': quiz.username,
    'title': quiz.title,
    'is_shared': quiz.isShared,
  }));
  final response = await http.put(Uri.parse(quiz.url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'url': quiz.url,
        'user': quiz.user,
        'username': quiz.username,
        'title': quiz.title,
        'is_shared': quiz.isShared,
      }));
  print(response.body);
  if (response.statusCode == 200) {
    final quizJson = jsonDecode(response.body);
    print(quizJson);
    return Quiz.fromJson(quizJson);
  } else {
    showQToast("Failed to update question", true);
    throw Exception('Failed to update question.');
  }
}

Future<Quiz> updateQuizProfile(Quiz quiz) async {
  var request = http.MultipartRequest(
    'PATCH',
    Uri.parse(quiz.url),
  );

  request.fields['url'] = quiz.url;
  request.fields['user'] = quiz.user;
  request.fields['username'] = quiz.username;
  request.fields['title'] = quiz.title;
  request.fields['is_shared'] = quiz.isShared.toString();

  if (quiz.image != '') {
    request.files.add(http.MultipartFile(
      'image',
      File(quiz.image!).readAsBytes().asStream(),
      File(quiz.image!).lengthSync(),
      filename: quiz.image!.split('/').last,
    ));
  } else {
    // Set profile picture to existing one if user doesn't upload a new one
    // request.fields['profile_picture'] = 'null';
  }

  request.headers.addAll(<String, String>{
    'Content-Type': 'multipart/form-data',
  });

  final response = await http.Response.fromStream(await request.send());
  print(jsonDecode(response.body));
  if (response.statusCode == 200) {
    final quizJson = jsonDecode(response.body);
    return Quiz.fromJson(quizJson);
  } else {
    throw Exception('Failed to update quiz.');
  }
}

Future<Quiz> getQuiz(Quiz quiz) async {
  final response = await http.get(
    Uri.parse(quiz.url),
  );
  if (response.statusCode == 200) {
    final tokenJson = jsonDecode(response.body);
    return Quiz.fromJson(tokenJson);
  } else {
    throw Exception('Failed to load quiz details.');
  }
}