import 'package:flutter/material.dart';
//widgets
import 'package:quizpix/widgets/home_button.dart';
import 'package:quizpix/widgets/q_dropdown_button.dart';
import 'package:quizpix/widgets/quiz_item.dart';
import 'package:quizpix/widgets/search_bar.dart';
//samples
import 'package:quizpix/samples/items.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeButton(isFree: true, isActive: true, onPress: () {}),
                      HomeButton(isFree: false, isActive: false, onPress: () {}),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    style: Theme.of(context).textTheme.headline3!.merge(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                    'Search Quizzes'
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const SearchBar(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                            style: Theme.of(context).textTheme.headline3!.merge(TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                          'Available Quizzes'
                        ),
                      ),
                      const QDropdownButton(isSort: true),
                      const SizedBox(width: 10.0),
                      const QDropdownButton(isSort: false)
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return QuizItem(
                        author: items[index].author,
                        title: items[index].title,
                        onPress: () {},
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                  )
                ),
              ],
            )
          )
        ),
      ),
    );
  }
}