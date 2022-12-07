import 'package:flutter/material.dart';
import 'package:quizpix/samples/questions.dart';
import 'package:quizpix/screens/home_tab.dart';
import 'package:quizpix/screens/login.dart';
import 'package:quizpix/screens/registration.dart';
import 'package:quizpix/screens/scan_confirmation.dart';
import 'package:quizpix/screens/scan_tab.dart';
import 'package:quizpix/screens/home_controller.dart';
import 'package:quizpix/screens/view_quiz.dart';
import 'package:quizpix/widgets/home_button.dart';
import 'package:quizpix/widgets/pro_card.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_button_outline.dart';
import 'package:quizpix/widgets/question_list.dart';
import 'package:quizpix/widgets/q_icon_button.dart';
import 'package:quizpix/widgets/quiz_item.dart';
import 'package:quizpix/widgets/q_dropdown_button.dart';
import 'package:quizpix/widgets/search_bar.dart';
import 'package:quizpix/widgets/stat_card.dart';
import 'package:quizpix/widgets/scan_button.dart';
import 'package:quizpix/widgets/q_text_field.dart';

void main() {
  runApp(const MyApp());
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeController(),
      },
      theme: ThemeData(
        backgroundColor: const Color(0xfff5f5f5),
        //color palette
        colorScheme: const ColorScheme.light().copyWith(
          //primary orange
          primary: const Color(0xfff69036),
          onPrimary: const Color(0xffffffff),
          //accent purple
          secondary: const Color(0xff6d5271),
          onSecondary: const Color(0xffffffff),
          //accent orange
          tertiary: const Color(0xfffebd54),
        ),
        //default text
        fontFamily: 'Futura',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w700,
          ),
          headline2: TextStyle(fontSize: 30.0),
          headline3: TextStyle(fontSize: 20.0),
          bodyText1: TextStyle(fontSize: 16.0),
          subtitle1: TextStyle(fontSize: 12.0),
        ),
        //button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                side: const BorderSide(
                  color: Color(0xfff69036),
                  width: 5,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)))),
        //icon
        iconTheme: const IconThemeData(size: 20.0),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}