import 'package:flutter/material.dart';
import 'package:quizpix/globals/globals.dart';
import 'package:quizpix/helpers/question.dart';
import 'package:quizpix/helpers/quiz.dart';
import 'package:quizpix/screens/edit_questions.dart';
import 'package:quizpix/screens/game_controller.dart';
import 'package:quizpix/widgets/edit_quiz_dialog.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_icon_button.dart';
import 'package:quizpix/widgets/q_toast.dart';
import 'package:quizpix/widgets/question_list.dart';
import 'package:quizpix/models/question.dart';
import 'package:quizpix/models/quiz.dart';

class ViewQuiz extends StatefulWidget {
  const ViewQuiz(
      // {super.key,
      // required this.author,
      // required this.title,
      // required this.questions});
      {super.key,
      required this.quiz,
      required this.onPop});

  // final String author;
  // final String title;
  // final List<Question> questions;
  final Quiz quiz;
  final VoidCallback onPop;

  @override
  State<ViewQuiz> createState() => _ViewQuizState();
}

class _ViewQuizState extends State<ViewQuiz> {
  List<Question>? questions;
  String tempTitle = '';
  String? tempImg = '';
  bool tempIsShared = false;

  @override
  void initState() {
    super.initState();
    tempTitle = widget.quiz.title;
    tempImg = widget.quiz.image;
    tempIsShared = widget.quiz.isShared;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchQuestions();
    });
  }

  void fetchQuestions() async {
    try {
      List<Question> result = await getQuizQuestions(widget.quiz);
      setState(() {
        questions = result;
      });
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  Future<dynamic> displayEditQuizDialog(BuildContext context) async {
    Quiz temp = Quiz(
      widget.quiz.url,
      widget.quiz.user,
      widget.quiz.username,
      tempImg,
      tempTitle,
      tempIsShared,
    );
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return EditQuizDialog(
            onPop: () async {
              Quiz temp = await getQuiz(widget.quiz);
              tempTitle = temp.title;
              tempImg = temp.image;
              setState(() {});
            },
            quiz: temp,
          );
        });
  }

  Future<dynamic> displayDeleteDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding:
                const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            actionsPadding:
                const EdgeInsets.only(top: 8.0, right: 20.0, bottom: 8.0),
            title: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xfff69036),
                ),
                children: [
                  const TextSpan(text: 'Delete '),
                  TextSpan(
                      text: widget.quiz.title,
                      style: const TextStyle(color: Color(0xff6d5271))),
                  const TextSpan(text: '?'),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await deleteQuiz(widget.quiz.url);
                  widget.onPop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(32, 32),
                  backgroundColor: const Color(0xfff69036),
                  elevation: 6.0,
                ),
                child: const Text('Delete', style: TextStyle(fontSize: 16.0)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(32, 32),
                  backgroundColor: const Color(0xff6d5271),
                  elevation: 6.0,
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 16.0)),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfffafafa),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 16.0, right: 0.0, bottom: 0.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Color(0xff6d5271),
                      ),
                      onPressed: () {
                        widget.onPop();
                        Navigator.pop(context);
                      },
                    ),
                    widget.quiz.user == localDetails.url
                        ? IconButton(
                            padding: const EdgeInsets.only(
                                left: 0.0, top: 16.0, right: 20.0, bottom: 0.0),
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.edit,
                              size: 30.0,
                              color: Color(0xff6d5271),
                            ),
                            onPressed: () {
                              displayEditQuizDialog(context);
                            },
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 160.0,
                  width: 160.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: tempImg != null
                      ? Image.network(tempImg!)
                      : Image.asset('assets/images/book.png'),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    tempTitle,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff69036),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    "Quiz Maker: ${widget.quiz.username}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff6d5271),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: QButton(
                    label: "Play Quiz",
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GameController(
                            questions: questions!,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.play_circle_outlined,
                      size: 30.0,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                widget.quiz.user == localDetails.url
                    ? Column(
                        children: [
                          const SizedBox(height: 12.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: QButton(
                              label:
                                  tempIsShared ? "Unshare Quiz" : "Share Quiz",
                              onPress: () async {
                                print(localDetails.status);
                                if (localDetails.status == 'pro') {
                                  Quiz temp = Quiz(
                                    widget.quiz.url,
                                    widget.quiz.user,
                                    widget.quiz.username,
                                    tempImg,
                                    tempTitle,
                                    !tempIsShared,
                                  );
                                  await updateQuiz(temp);
                                  setState(() {
                                    tempIsShared = !tempIsShared;
                                  });
                                  showQToast("Quiz updated.", false);
                                } else {
                                  showQToast(
                                      "You must be a PRO user to access this feature.",
                                      true);
                                }
                              },
                              icon: const Icon(
                                Icons.share,
                                size: 30.0,
                                color: Color(0xffffffff),
                              ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Questions",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xfff69036),
                        ),
                      ),
                      widget.quiz.user == localDetails.url
                          ? Row(
                              children: [
                                QIconButton(
                                  onPress: () async {
                                    displayDeleteDialog(context);
                                  },
                                  icon: Icons.delete,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                QIconButton(
                                  onPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditQuestions(
                                            questions: questions!,
                                            onPop: () async {
                                              fetchQuestions();
                                              setState(() {});
                                            }),
                                      ),
                                    );
                                  },
                                  icon: Icons.edit,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 12.0, right: 20.0, bottom: 32.0),
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 12.0, right: 20.0, bottom: 20.0),
                      constraints: const BoxConstraints(
                        minHeight: 200.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: const Color(0xfff69036),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: questions == null
                          ? const Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: SizedBox(
                                      height: 40.0,
                                      width: 40.0,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : QuestionList(questions: questions!)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
