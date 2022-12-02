import 'package:flutter/material.dart';
import 'package:quizpix/widgets/q_button.dart';

class ProCard extends StatelessWidget {
  const ProCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Color(0x1af69036),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xfff69036),
              ),
              children: [
                TextSpan(text: 'Quiz'),
                TextSpan(
                    text: 'Pix ', style: TextStyle(color: Color(0xff6d5271))),
                TextSpan(text: 'Pro Benefits'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Icon(
                  Icons.share_outlined,
                  size: 30.0,
                  color: Color(0xff6d5271),
                ),
              ),
              const Text(
                "Share your quizzes to your friends!",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff6d5271),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Icon(
                  Icons.play_circle_outlined,
                  size: 30.0,
                  color: Color(0xff6d5271),
                ),
              ),
              const Text(
                "Play other people's quizzes",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff6d5271),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          QButton(label: "Become a PRO", onPress: () {}),
        ],
      ),
    );
  }
}
