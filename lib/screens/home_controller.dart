import 'package:flutter/material.dart';
//screens
import 'package:quizpix/screens/home_tab.dart';
import 'package:quizpix/screens/profile_tab.dart';
import 'package:quizpix/screens/scan_tab.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int currentIndex = 0;

  static const List<Widget> homeOptions = <Widget>[
    ProfileTab(),
    ScanTab(),
    HomeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfffafafa),
        body: homeOptions.elementAt(currentIndex),
        bottomNavigationBar: Container(
            height: 60.0,
            margin:
                const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xfff6f6f6),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      icon: currentIndex == 0
                          ? Icon(Icons.person_outline_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30.0)
                          : const Icon(Icons.person_outline_rounded,
                              color: Color(0xffd3d3d3), size: 30.0)),
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      icon: currentIndex == 1
                          ? Icon(Icons.camera_enhance_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30.0)
                          : const Icon(Icons.camera_enhance_rounded,
                              color: Color(0xffd3d3d3), size: 30.0)),
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      icon: currentIndex == 2
                          ? Icon(Icons.home,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30.0)
                          : const Icon(Icons.home,
                              color: Color(0xffd3d3d3), size: 30.0)),
                ])));
  }
}
