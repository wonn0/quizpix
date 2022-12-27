import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.type,
    required this.name,
    required this.number,
    required this.isActive,
    required this.onTap,
    this.expDate,
  });

  final String type;
  final String name;
  final String number;
  final bool isActive;
  final Function() onTap;
  final String? expDate;

  Widget getIcon() {
    switch (type) {
      case "mastercard":
        return SizedBox(
            height: 16.0,
            child: Image.asset('assets/images/mastercard_logo.png',
                fit: BoxFit.fitHeight));
      case "gcash":
        return SizedBox(
            height: 16.0,
            child: Image.asset('assets/images/gcash_logo.png',
                fit: BoxFit.fitHeight));
      default:
        return SizedBox(
            height: 16.0,
            child: Image.asset('assets/images/mastercard_logo.png',
                fit: BoxFit.fitHeight));
    }
  }

  String getText() {
    switch (type) {
      case "mastercard":
        return "CARD HOLDER";
      case "gcash":
        return "NAME";
      default:
        return "CARD HOLDER";
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
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          height: 120.0,
          decoration: BoxDecoration(
            color: const Color(0xfffafafa),
            border: isActive == true
                ? Border.all(width: 1, color: const Color(0xfff69036))
                : null,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIcon(),
                  isActive == true
                      ? const Icon(
                          Icons.check_circle,
                          size: 16.0,
                          color: Color(0xfff69036),
                        )
                      : Container()
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                number,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xffd3d3d3),
                ),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getText(),
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xffd3d3d3),
                    ),
                  ),
                  type == "mastercard"
                      ? const Text(
                          "EXP DATE",
                          style: TextStyle(
                            fontSize: 8,
                            color: Color(0xffd3d3d3),
                          ),
                        )
                      : Container()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xffd3d3d3),
                    ),
                  ),
                  expDate != null
                      ? Text(
                          expDate!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xffd3d3d3),
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
