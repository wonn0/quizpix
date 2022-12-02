import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.type, required this.value});

  final String type;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 15
          )
        ],
        color: const Color(0xfffafafa),
      ),
      padding: const EdgeInsets.all(16.0),
      width: 150.0,
      height: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w700,
            )),
            type == 'quiz' ? 'Quizzes Made' : 'Total Score'
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    size: 30.0,
                    color: Theme.of(context).colorScheme.primary,
                    type == 'quiz' ? Icons.quiz : Icons.star,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    style: Theme.of(context).textTheme.headline2!.merge(TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    )),
                    "$value"
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}