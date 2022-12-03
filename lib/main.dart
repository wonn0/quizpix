import 'package:flutter/material.dart';
import 'package:quizpix/widgets/home_button.dart';
import 'package:quizpix/widgets/pro_card.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/quiz_item.dart';
import 'package:quizpix/widgets/q_dropdown_button.dart';
import 'package:quizpix/widgets/search_bar.dart';
import 'package:quizpix/widgets/stat_card.dart';
import 'package:quizpix/widgets/scan_button.dart';
import 'package:quizpix/widgets/q_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const StatCard(
            //   type: 'quiz',
            //   value: 150,
            // ),
            // const StatCard(
            //   type: 'score',
            //   value: 150,
            // ),
            // scan button samples:
            // ScanButton(
            //   label: 'Image',
            //   icon: Icon(
            //     Icons.camera_alt,
            //     size: 50.0,
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            //   onPress: () {},
            //   isLeft: true,
            // ),
            // ScanButton(
            //   label: 'Image',
            //   icon: Icon(
            //     Icons.camera_alt,
            //     size: 50.0,
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            //   onPress: () {},
            //   isLeft: false,
            // ),
            // button sample
            //QButton(onPress: () {}, label: 'button test', icon: null),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const QTextField(label: "Email Address"),
            // QTextField(label: "Email Address");
            // ProCard(),
            // SearchBar(),
            // HomeButton(
            //   isFree: true,
            //   isActive: false,
            //   onPress: () {},
            // ),
            QDropdownButton(isSort: true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
