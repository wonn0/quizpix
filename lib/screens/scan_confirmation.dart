import 'package:flutter/material.dart';
import 'package:quizpix/screens/quiz_generated.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_button_outline.dart';

class ScanConfirmation extends StatefulWidget {
  const ScanConfirmation({super.key, this.title, this.text});

  final String? title;
  final String? text;

  @override
  State<ScanConfirmation> createState() => _ScanConfirmationState();
}

class _ScanConfirmationState extends State<ScanConfirmation> {
  TextEditingController? scantextController;

  @override
  void initState() {
    super.initState();
    scantextController = TextEditingController(text: widget.text);
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizGenerated()));
                                }),
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
