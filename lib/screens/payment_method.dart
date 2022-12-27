import 'package:flutter/material.dart';
import 'package:quizpix/samples/payment_accounts.dart';
import 'package:quizpix/screens/payment_gcash.dart';
import 'package:quizpix/screens/payment_mastercard.dart';
import 'package:quizpix/widgets/payment_button.dart';
import 'package:quizpix/widgets/payment_card.dart';
import 'package:quizpix/widgets/q_button.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    super.key,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int activeInd = 0;

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
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: const EdgeInsets.only(left: 20.0, top: 16.0),
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
                    left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                child: const Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xfff69036),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: paymentAccounts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: PaymentCard(
                              type: paymentAccounts[index].type,
                              name: paymentAccounts[index].name,
                              number: paymentAccounts[index].number,
                              isActive: activeInd == index ? true : false,
                              onTap: () {
                                setState(() {
                                  activeInd = index;
                                });
                              },
                              expDate: paymentAccounts[index].expDate != ""
                                  ? paymentAccounts[index].expDate
                                  : null,
                            ),
                          );
                        },
                      ),
                      PaymentButton(
                          type: "mastercard",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentMastercard(),
                              ),
                            );
                          }),
                      const SizedBox(height: 20.0),
                      PaymentButton(
                          type: "gcash",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentGCash(),
                              ),
                            );
                          }),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20.0, bottom: 32.0),
                child: QButton(
                    label: "Pay Now",
                    onPress: () {
                      // Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
