import 'package:flutter/material.dart';
import 'package:quizpix/screens/view_quiz.dart';
//widgets
import 'package:quizpix/widgets/home_button.dart';
import 'package:quizpix/widgets/q_dropdown_button.dart';
import 'package:quizpix/widgets/quiz_item.dart';
import 'package:quizpix/widgets/search_bar.dart';
//samples
import 'package:quizpix/samples/items.dart';
import 'package:quizpix/samples/questions.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isActiveFree = true;
  bool isActivePremium = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          // padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeButton(
                            isFree: true,
                            isActive: isActiveFree,
                            onPress: () {
                              setState(() {
                                isActiveFree = true;
                                isActivePremium = false;
                              });
                            }),
                        const SizedBox(width: 16.0),
                        HomeButton(
                            isFree: false,
                            isActive: isActivePremium,
                            onPress: () {
                              setState(() {
                                isActiveFree = false;
                                isActivePremium = true;
                              });
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .merge(TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        'Search Quizzes'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: const SearchBar(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .merge(TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              'Available Quizzes'),
                        ),
                        const QDropdownButton(isSort: true),
                        const SizedBox(width: 16.0),
                        const QDropdownButton(isSort: false)
                      ],
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: QuizItem(
                            author: items[index].author,
                            title: items[index].title,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewQuiz(
                                    author: items[index].author,
                                    title: items[index].title,
                                    questions: questions,
                                  ),
                                ),
                              );
                            },
                          ));
                    },
                  )),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
