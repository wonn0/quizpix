import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:quizpix/widgets/q_toast.dart';

import '../env.sample.dart';
import '../models/user.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();

  bool verifyRegistration() {
    if (emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        conpasswordController.text.isEmpty) {
      showQToast("Please fill up all fields", true);
      return false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showQToast("Please use a valid email", true);
      return false;
    } else if (passwordController.text != conpasswordController.text) {
      showQToast("Passwords don't match", true);
      return false;
    }
    return true;
  }

  Future<User> createUser(User user) async {
    late NavigatorState dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = Navigator.of(context);
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final response = await http.post(Uri.parse('${Env.URL_PREFIX}/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': user.username,
          'password': user.password,
          'email': user.email,
          'title': user.title,
          'profile_picture': null,
          'is_active': true,
          'quizzes_made': 0,
          'total_score': 0,
          'status': 'regular',
        }));
    if (response.statusCode == 201) {
      final userJson = jsonDecode(response.body);
      return User.fromJson(userJson);
    } else {
      dialogContext.pop();
      showQToast("Failed to create account", true);
      throw Exception('Failed to create user.');
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 16.0, right: 0.0, bottom: 0.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Color(0xff6d5271),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, top: 28.0, right: 40.0, bottom: 28.0),
                    child: Image.asset('assets/images/quizpix_logo.png'),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Text(
                      "Sign Up",
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
                      label: "Email Address",
                      textController: emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "Username",
                      textController: usernameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "Password",
                      textController: passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "Confirm Password",
                      textController: conpasswordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 12.0, right: 20.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0x996d5271),
                          letterSpacing: 0.2,
                          wordSpacing: 0.5,
                          height: 2,
                        ),
                        children: [
                          TextSpan(text: 'By signing up, you agree to the '),
                          TextSpan(
                              text: 'Terms & Conditions ',
                              style: TextStyle(color: Color(0xff6d5271))),
                          TextSpan(text: 'and '),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Color(0xff6d5271))),
                        ],
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
                      child: QButton(
                          label: "Complete Registration",
                          onPress: () {
                            if (verifyRegistration()) {
                              User user = User(
                                  null,
                                  usernameController.text,
                                  passwordController.text,
                                  emailController.text,
                                  'QuizPix Player',
                                  null,
                                  true,
                                  0,
                                  0,
                                  'regular');
                              createUser(user).then((response) {
                                // print(response.statusCode);
                                showQToast(
                                    "Successfully created account", false);
                                Navigator.pushNamed(context, '/');
                              });
                            }
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
