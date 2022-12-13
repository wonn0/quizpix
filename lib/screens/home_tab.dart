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
//models
import 'package:quizpix/models/item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isActiveFree = true;
  bool isActivePremium = false;

  List<Item> currItems = items;
  TextEditingController searchController = TextEditingController();

  void filterItems() {
    List<Item> results = [];
    if (searchController.text.isEmpty) {
      results = items;
    } else {
      // Inside todosList, it will check for the todoText and check if it contains the enteredKeyword, then convert it to List since results is a List type
      results = items
          .where((item) => item.title
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {
      currItems = results;
    });
  }

  @override
  void initState() {
    super.initState();

    searchController.addListener(filterItems);
  }

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
                    child: SearchBar(controller: searchController),
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
                    itemCount: currItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: QuizItem(
                            author: currItems[index].author,
                            title: currItems[index].title,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewQuiz(
                                    author: currItems[index].author,
                                    title: currItems[index].title,
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