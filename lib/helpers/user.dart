import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.sample.dart';
import '../models/user.dart';
import '../globals/globals.dart';

Future<User> getUser(String username) async {
  final response = await http.get(
    Uri.parse('${Env.URL_PREFIX}/users?username=$username'),
  );
  if (response.statusCode == 200) {
    final tokenJson = jsonDecode(response.body);
    return User.fromJson(tokenJson.first);
  } else {
    throw Exception('Failed to load user details.');
  }
}

Future<User> updateUser(BuildContext context, User user) async {
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
  print(jsonEncode(<String, dynamic>{
    "url": user.url!,
    'username': user.username,
    'password': user.password,
    'email': user.email,
    'title': user.title,
    'profile_picture': user.profilePicture,
    'is_active': true,
    'quizzes_made': user.quizzesMade,
    'total_score': user.totalScore,
    'status': 'regular',
  }));
  final response = await http.patch(Uri.parse(user.url!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "url": user.url!,
        'username': user.username,
        'password': user.password,
        'email': user.email,
        'title': user.title,
        'profile_picture': user.profilePicture,
        'is_active': true,
        'quizzes_made': user.quizzesMade,
        'total_score': user.totalScore,
        'status': 'regular',
      }));
  if (response.statusCode == 200) {
    final userJson = jsonDecode(response.body);
    localDetails = await getUser(localDetails.username);
    dialogContext.pop();
    return User.fromJson(userJson);
  } else {
    dialogContext.pop();
    throw Exception('Failed to update user.');
  }
}
