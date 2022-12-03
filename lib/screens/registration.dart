import 'package:flutter/material.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding:
              EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0, bottom: 32.0),
          decoration: BoxDecoration(
            color: const Color(0xfff5f5f5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: const Color(0xff6d5271),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(flex: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.asset('assets/images/quizpix_logo.png'),
              ),
              Spacer(flex: 2),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xfff69036),
                  ),
                ),
              ),
              Spacer(flex: 1),
              QTextField(label: "Email Address"),
              Spacer(flex: 1),
              QTextField(label: "Username"),
              Spacer(flex: 1),
              QTextField(label: "Password"),
              Spacer(flex: 1),
              QTextField(label: "Confirm Password"),
              Spacer(flex: 1),
              RichText(
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
              Spacer(flex: 2),
              QButton(label: "Complete Registration", onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
