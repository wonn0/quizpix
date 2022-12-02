import 'package:flutter/material.dart';

class QTextField extends StatelessWidget {
  const QTextField({super.key, required this.label});

  final String label;

  IconData iconPicker(String txt) {
    switch (txt) {
      case "Email Address":
        return Icons.alternate_email;
      case "Username":
      case "Name":
        return Icons.account_circle_outlined;
      case "Password":
      case "Confirm Password":
      case "New Password":
        return Icons.lock_outline;
      case "User Title":
        return Icons.card_membership_outlined;
      case "Phone Number":
        return Icons.phone_in_talk_outlined;
      case "Card Number":
        return Icons.credit_card_outlined;
      case "Expiry Date":
        return Icons.calendar_today_outlined;
      case "CVN":
        return Icons.verified_outlined;
      default:
        return Icons.alternate_email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              iconPicker(label),
              size: 30.0,
              color: const Color(0xff909090),
            ),
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              style: const TextStyle(
                color: Color(0xff909090),
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffd3d3d3),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffd3d3d3),
                  ),
                ),
                contentPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                labelText: label,
                labelStyle: const TextStyle(
                  color: Color(0xff909090),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
