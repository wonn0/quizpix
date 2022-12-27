import 'package:flutter/material.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_text_field.dart';

class PaymentGCash extends StatefulWidget {
  const PaymentGCash({
    super.key,
  });

  @override
  State<PaymentGCash> createState() => _PaymentGCashState();
}

class _PaymentGCashState extends State<PaymentGCash> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();

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
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: const Text(
                      "GCash Details",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff69036),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: QTextField(
                      label: "Name",
                      textController: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "Phone Number",
                      textController: phonenumController,
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
                          label: "Proceed",
                          onPress: () {
                            // Navigator.pop(context);
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
