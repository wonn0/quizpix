import 'dart:convert';
import 'dart:developer' as developer; //debugger

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_button_outline.dart';
import 'package:quizpix/widgets/q_text_field.dart';
import 'package:quizpix/widgets/q_toast.dart';
import 'package:http/http.dart' as http;

import '../env.sample.dart';
import '../models/token.dart';
import '../globals/globals.dart';
import '../helpers/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Future<Token> login(String username, String password) async {
//   final response = await http.post(Uri.parse('${Env.URL_PREFIX}/api/token'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'username': username,
//         'password': password,
//       }));
//   if (response.statusCode == 201) {
//     final tokenJson = jsonDecode(response.body);
//     token = tokenJson.access;
//     return Token.fromJson(tokenJson);
//   } else {
//     throw Exception('Failed to create user.');
//   }
// }

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool verifyLogin() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      showQToast("Please fill up all fields", true);
      return false;
    }
    return true;
  }

  Future<Token> login(String username, String password) async {
    final response = await http.post(Uri.parse('${Env.URL_PREFIX}/api/token/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
        }));
    if (response.statusCode == 200) {
      final tokenJson = jsonDecode(response.body);
      //set current user to username and store globally
      localDetails = await getUser(username);
      // print(localDetails.toString());
      return Token.fromJson(tokenJson);
    } else if (response.statusCode == 401) {
      throw Exception('Invalid login.');
    } else {
      throw Exception('Something wrong happened. Please try again later.');
    }
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 48.0),
                    child: Image.asset('assets/images/quizpix_logo.png'),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff69036),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 12.0, right: 20.0),
                    child: QTextField(
                      label: "Username",
                      textController: usernameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 12.0, right: 20.0),
                    child: QTextField(
                      label: "Password",
                      textController: passwordController,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                      ),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xff6d5271),
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
                          left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                      child: QButton(
                          label: "Login",
                          onPress: () {
                            if (verifyLogin()) {
                              login(usernameController.text,
                                      passwordController.text)
                                  .then((response) {
                                Navigator.pushNamed(context, '/home');
                              });
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 1.0,
                              color: Color(0xffd3d3d3),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Color(0xffd3d3d3),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.0,
                              color: Color(0xffd3d3d3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20.0, right: 20.0, bottom: 32.0),
                      child: QButtonOutline(
                          label: "Sign Up",
                          onPress: () {
                            Navigator.pushNamed(context, '/register');
                          }),
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
