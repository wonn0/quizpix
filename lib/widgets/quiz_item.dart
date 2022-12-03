import 'package:flutter/material.dart';

class QuizItem extends StatefulWidget {
  const QuizItem({super.key, required this.author, required this.title, required this.onPress});

  final String author;
  final String title;
  final Function() onPress;

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(4, 8), // Shadow position
          ),
        ]
      ),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xfff6f6f6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: InkWell(
            onTap: widget.onPress,
            borderRadius: BorderRadius.circular(8.0),          
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 60.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xffd9d9d9),
                    ),
                    height: double.infinity,
                    width: 40.0,
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      fit: BoxFit.contain,
                      'assets/images/book1.jpg'
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: const EdgeInsets.only(left: 12.0),
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                            widget.title
                          ),
                          Text(
                            style: Theme.of(context).textTheme.subtitle1!.merge(const TextStyle(
                              color: Color(0x996d5271)
                            )),
                            'Quiz Maker: ${widget.author}'
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(
                    size: 40.0,
                    color: Color(0xffd3d3d3),
                    Icons.chevron_right_sharp,
                  )
                ],
              ),
            )
          )
        )
      )
    );
  }
}