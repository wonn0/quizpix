import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key, required this.type, required this.onTap});

  final String type;
  final Function onTap;

  String getText() {
    switch (type) {
      case "mastercard":
        return "+ Add Mastercard account";
      case "gcash":
        return "+ Add GCash account";
      default:
        return "+ Add Mastercard account";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(4, 4), // Shadow position
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xfffafafa),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: InkWell(
            onTap: () {
              onTap();
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 120.0,
              child: Center(
                child: Text(getText(),
                    style: const TextStyle(
                        fontSize: 20.0, color: Color(0xffd3d3d3))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
