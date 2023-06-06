import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quizpix/widgets/q_toast.dart';

import '../env.sample.dart';
import '../models/question.dart';
import '../models/quiz.dart';

Future<List<Question>> getQuizQuestions(Quiz quiz) async {
  RegExp regExp = RegExp(r'quizzes/(\d+)');
  Match? match = regExp.firstMatch(quiz.url);
  final response = await http.get(
    Uri.parse('${Env.URL_PREFIX}/questions/?quiz=${match!.group(1)}'),
  );
  print(response.headers);
  print(response.body);
  if (response.statusCode == 200) {
    final questionsJson = jsonDecode(response.body);
    final List<Question> questions = questionsJson
        .map<Question>(
            (json) => Question.fromJson(json as Map<String, dynamic>))
        .toList();
    return questions;
  } else {
    print("Failed to get quizzes with status code ${response.statusCode}");
    showQToast(
        "Failed to get quizzes with status code ${response.statusCode}", true);
    throw Exception('Failed to get quizzes.');
  }
}

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

Future<Question> updateQuestion(Question question) async {
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
    'url': question.url,
    'quiz': question.quiz,
    'type': question.type,
    'question': question.question,
    'answer': question.answer,
    'choices': question.choices,
  }));
  final response = await http.put(Uri.parse(question.url!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'url': question.url,
        'quiz': question.quiz,
        'type': question.type,
        'question': question.question,
        'answer': question.answer,
        'choices': question.choices,
      }));
  print(response.body);
  if (response.statusCode == 200) {
    final questionJson = jsonDecode(response.body);
    print(questionJson);
    return Question.fromJson(questionJson);
  } else {
    showQToast("Failed to update question", true);
    throw Exception('Failed to update question.');
  }
}

Future<void> deleteQuestion(Question question) async {
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
  final response =
      await http.delete(Uri.parse(question.url!), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  print(response);
  if (response.statusCode == 204) {
    print(response.statusCode);
  } else {
    showQToast("Failed to delete question", true);
    throw Exception('Failed to delete question.');
  }
}
