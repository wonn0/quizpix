library quizpix.globals;

import '../models/token.dart';
import '../models/user.dart';
import '../models/quiz.dart';

Token token = Token("", "");

User localDetails = User(
  null,
  "",
  "",
  "",
  "",
  "",
  false,
  0,
  0,
  "",
);

List<Quiz> quizzes = [];