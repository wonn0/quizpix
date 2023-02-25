import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.confirm,
    required this.confirmContext,
    required this.action,
  });

  final Function(NavigatorState) confirm;
  final NavigatorState confirmContext;
  final String action;

  List<String> getWords() {
    switch (action) {
      case "Registration":
        return ['Registration', 'register'];
      case "Sign Out":
        return ['Sign Out', 'sign out'];
      case "Edit Profile":
        return ['Edit Profile', 'edit your profile'];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      contentPadding: const EdgeInsets.only(
          left: 20.0, top: 20.0, right: 20.0, bottom: 8.0),
      actionsPadding: const EdgeInsets.only(right: 20.0, bottom: 8.0),
      title: Text(
        'Confirm ${getWords()[0]}',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Color(0xfff69036),
        ),
      ),
      content: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to ${getWords()[1]}?',
                style: const TextStyle(
                  color: Color(0xff6d5271),
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            confirm(confirmContext);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(32, 32),
            backgroundColor: const Color(0xfff69036),
            elevation: 4.0,
          ),
          child: const Text('Confirm', style: TextStyle(fontSize: 16.0)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(32, 32),
            backgroundColor: const Color(0xff6d5271),
            elevation: 4.0,
          ),
          child: const Text('Cancel', style: TextStyle(fontSize: 16.0)),
        ),
      ],
    );
  }
}
