import 'package:flutter/material.dart';

class QTextField extends StatefulWidget {
  const QTextField(
      {super.key, required this.label, required this.textController});

  final String label;
  final TextEditingController textController;

  @override
  State<QTextField> createState() => _QTextFieldState();
}

class _QTextFieldState extends State<QTextField> {
  bool isVisible = true;

  bool isPassword(String txt) {
    switch (txt) {
      case "Password":
      case "Confirm Password":
      case "New Password":
        return true;
      default:
        return false;
    }
  }

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
          Expanded(
            child: TextField(
              maxLines: 1,
              obscureText: isPassword(widget.label) && !isVisible,
              controller: widget.textController,
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
                contentPadding: const EdgeInsets.only(right: 4.0),
                labelText: widget.label,
                labelStyle: const TextStyle(
                  color: Color(0xff909090),
                ),
                icon: IconButton(
                  onPressed: null,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    iconPicker(widget.label),
                    size: 30.0,
                    color: const Color(0xff909090),
                  ),
                ),
                suffixIcon: isPassword(widget.label)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          maxHeight: 16.0,
                        ),
                        icon: Icon(
                          isVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 16.0,
                          color: const Color(0xff909090),
                        ),
                      )
                    : const SizedBox(height: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
