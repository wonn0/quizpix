import 'package:flutter/material.dart';
import 'package:quizpix/screens/login.dart';
import 'package:quizpix/screens/registration.dart';
import 'package:quizpix/screens/home_controller.dart';

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
          //background color
          background: const Color(0xfff5f5f5),
        ),
        //default text
        fontFamily: 'Futura',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w700,
          ),
          displayMedium: TextStyle(fontSize: 30.0),
          displaySmall: TextStyle(fontSize: 20.0),
          bodyLarge: TextStyle(fontSize: 16.0),
          titleMedium: TextStyle(fontSize: 12.0),
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
      debugShowCheckedModeBanner: true, //only set to true when debugging
    );
  }
}
