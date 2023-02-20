import 'dart:convert';

class User {
  final int? id;
  final String username;
  final String password;
  final String email;
  final String title;
  final String? profilePicture;
  final bool isActive;
  final int quizzesMade;
  final int totalScore;
  final String status;

  User(
      this.id,
      this.username,
      this.password,
      this.email,
      this.title,
      this.profilePicture,
      this.isActive,
      this.quizzesMade,
      this.totalScore,
      this.status);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        email = json['email'],
        title = json['title'],
        profilePicture = json['profile_picture'],
        isActive = json['is_active'],
        quizzesMade = json['quizzes_made'],
        totalScore = json['total_score'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'email': email,
        'title': title,
        'profile_picture': profilePicture,
        'is_active': isActive,
        'quizzes_made': quizzesMade,
        'total_score': totalScore,
        'status': status,
      };
}
