import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizpix/widgets/q_toast.dart';

import '../env.sample.dart';
import '../models/user.dart';
import '../globals/globals.dart';

Future<User> getUser(String username) async {
  final response = await http.get(
    Uri.parse('${Env.URL_PREFIX}/users/?username=$username'),
  );
  if (response.statusCode == 200) {
    final tokenJson = jsonDecode(response.body);
    return User.fromJson(tokenJson.first);
  } else {
    throw Exception('Failed to load user details.');
  }
}

Future<User> updateUserDetails(BuildContext context, User user) async {
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
        'is_active': true,
        'quizzes_made': user.quizzesMade,
        'total_score': user.totalScore,
        'status': 'regular',
        'items': user.items,
      }));
  if (response.statusCode == 200) {
    final userJson = jsonDecode(response.body);
    localDetails = await getUser(localDetails.username);
    dialogContext.pop();
    return User.fromJson(userJson);
  } else {
    dialogContext.pop();
    showQToast("Please try again later", true);
    throw Exception('Failed to update user.');
  }
}

Future<User> updateQuizzesMade() async {
  final response = await http.patch(Uri.parse(localDetails.url!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "url": localDetails.url!,
        'username': localDetails.username,
        'password': "",
        'email': localDetails.email,
        'title': localDetails.title,
        'is_active': true,
        'quizzes_made': localDetails.quizzesMade + 1,
        'total_score': localDetails.totalScore,
        'status': 'regular',
        'items': localDetails.items,
      }));
  if (response.statusCode == 200) {
    final userJson = jsonDecode(response.body);
    localDetails = await getUser(localDetails.username);
    return User.fromJson(userJson);
  } else {
    showQToast("Please try again later", true);
    throw Exception('Failed to update user.');
  }
}

//for updating profile picture; use updateUserDetails if you're not going to pass an image file
Future<User> updateUserProfile(BuildContext context, User user) async {
  var request = http.MultipartRequest(
    'PATCH',
    Uri.parse(user.url!),
  );

  request.fields['username'] = user.username;
  request.fields['password'] = user.password;
  request.fields['email'] = user.email;
  request.fields['title'] = user.title;
  request.fields['is_active'] = 'true';
  request.fields['quizzes_made'] = user.quizzesMade.toString();
  request.fields['total_score'] = user.totalScore.toString();
  request.fields['status'] = 'regular';
  for (int i = 0; i < user.items.length; i++) {
    request.fields['items[$i]'] = user.items[i].toString();
  }

  if (user.profilePicture != '') {
    request.files.add(http.MultipartFile(
      'profile_picture',
      File(user.profilePicture!).readAsBytes().asStream(),
      File(user.profilePicture!).lengthSync(),
      filename: user.profilePicture!.split('/').last,
    ));
  } else {
    // Set profile picture to existing one if user doesn't upload a new one
    // request.fields['profile_picture'] = 'null';
  }

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
  // print(jsonDecode(response.body)[0]);
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
