import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quizpix/models/question.dart';

class EditQuestionsProvider extends ChangeNotifier {
  final List<Question> _tempQuestions = [];
  UnmodifiableListView<Question> get tempQuestions =>
      UnmodifiableListView(_tempQuestions);

  void initTemp(List<Question> questions) {
    _tempQuestions.addAll(questions);
  }

  void add(Question question) {
    _tempQuestions.add(question);
    notifyListeners();
  }

  void update(Question question, int index) {
    _tempQuestions[index] = question;
    notifyListeners();
  }

  void delete(int index) {
    _tempQuestions.removeAt(index);
    notifyListeners();
  }
}
