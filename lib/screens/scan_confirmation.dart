import 'package:flutter/material.dart';
import 'package:quizpix/globals/globals.dart';
import 'package:quizpix/helpers/user.dart';
import 'package:quizpix/screens/quiz_generated.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_button_outline.dart';
import 'package:quizpix/widgets/q_toast.dart';

import '../helpers/quiz.dart';
import '../helpers/question.dart';
import '../models/quiz.dart';
import '../models/question.dart';
import '../models/user.dart';

class ScanConfirmation extends StatefulWidget {
  const ScanConfirmation({super.key, this.title, this.text});

  final String? title;
  final String? text;

  @override
  State<ScanConfirmation> createState() => _ScanConfirmationState();
}

class _ScanConfirmationState extends State<ScanConfirmation> {
  TextEditingController? scantextController;
  Quiz result = Quiz('', '', '', '', '', false);

  @override
  void initState() {
    super.initState();
    scantextController = TextEditingController(text: widget.text);
  }

  // for debugging string
  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }

  Future<Quiz> generateQuiz(BuildContext context, String text) async {
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
    Map<String, dynamic> quiz = await getQuestions(context, text);
    List<dynamic> questions = quiz['quiz'];
    //create the quiz object and store in database
    Quiz quizDetails = await createQuiz();
    //iterate over each question in the list and add it to the quiz we just made
    for (var question in questions) {
      Question temp = Question(
        null,
        quizDetails.url,
        question['type'],
        question['question'],
        question['answer'],
        // (question['choices'] as List<dynamic>).cast<String>(),
        question['choices'],
      );
      await createQuestion(temp);
    }
    User temp = User(
        localDetails.url,
        localDetails.username,
        localDetails.password,
        localDetails.email,
        localDetails.title,
        localDetails.profilePicture,
        true,
        localDetails.quizzesMade + 1,
        localDetails.totalScore,
        localDetails.status,
        localDetails.items);
    //update user details
    // await updateQuizzesMade();
    quizzes = await getUserQuizzes();
    result = quizDetails;
    return quizDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfff5f5f5),
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 40.0, right: 20.0, bottom: 40.0),
                    child: Text(
                      widget.title ?? "Finalize your reading material",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff69036),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      height: 460.0,
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 12.0, right: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: const Color(0xfff69036),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: TextField(
                        maxLines: null,
                        controller: scantextController,
                        style: const TextStyle(
                          color: Color(0xff6d5271),
                          fontSize: 16.0,
                          letterSpacing: 0.2,
                          wordSpacing: 0.5,
                          height: 1.2,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffd3d3d3),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffd3d3d3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20.0, right: 20.0, bottom: 32.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: QButtonOutline(
                                label: "Cancel",
                                onPress: () {
                                  Navigator.pushNamed(context, '/home');
                                }),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: QButton(
                              label: "Generate",
                              onPress: () {
                                String text = scantextController!.text.trim();
                                int wordCount =
                                    text.isEmpty ? 0 : text.split(" ").length;
                                if (scantextController!.text.isEmpty ||
                                    wordCount < 50) {
                                  showQToast(
                                      "Please enter at least 50 words.", true);
                                } else {
                                  generateQuiz(
                                          context, scantextController!.text)
                                      .then((response) async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            QuizGenerated(quiz: result),
                                      ),
                                    );
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
