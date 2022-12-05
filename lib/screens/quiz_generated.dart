import 'package:flutter/material.dart';
import 'package:quizpix/widgets/q_button.dart';

class QuizGenerated extends StatefulWidget {
  const QuizGenerated({super.key});

  @override
  State<QuizGenerated> createState() => _QuizGeneratedState();
}

class _QuizGeneratedState extends State<QuizGenerated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      style: Theme.of(context).textTheme.headline1!.merge(TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                      'Your Quiz is ready!'
                    ),
                    Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {}, 
                        iconSize: 40.0,
                        icon: const Icon(
                          color: Color(0xffffffff),
                          Icons.share,
                        )
                      )
                    ),
                  ]
                ),
                const SizedBox(height: 28.0),
                const Image(
                  image: AssetImage('assets/images/user1.jpg'),
                ),
                const SizedBox(height: 28.0),
                QButton(
                  onPress: () {},
                  label: 'View Quiz', 
                  icon: const Icon(Icons.visibility_outlined),
                ),
                const SizedBox(height: 28.0),
                QButton(
                  onPress: () {},
                  label: 'Play Quiz', 
                  icon: const Icon(Icons.gamepad_outlined),
                ),
                const SizedBox(height: 28.0),
                QButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  label: 'Scan Another', 
                  icon: const Icon(Icons.camera_enhance_outlined),
                )
              ]
            ),
          )
        )
      )
    );
  }
}