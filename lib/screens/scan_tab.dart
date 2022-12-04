import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizpix/widgets/scan_button.dart';

class ScanTab extends StatelessWidget {
  const ScanTab({super.key});

  Future scanCamera() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
    } on PlatformException {
      return;
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
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding:
                    const EdgeInsets.only(left: 20.0, top: 40.0, bottom: 40.0),
                child: const Text(
                  "Scan using...",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xfff69036),
                  ),
                ),
              ),
              ScanButton(
                  label: "Text",
                  icon: const Icon(
                    Icons.text_snippet_outlined,
                    size: 50.0,
                    color: Color(0xfff69036),
                  ),
                  onPress: () {},
                  isLeft: true),
              const Spacer(flex: 1),
              ScanButton(
                  label: "Input",
                  icon: const Icon(
                    Icons.edit_note_outlined,
                    size: 50.0,
                    color: Color(0xfff69036),
                  ),
                  onPress: () {},
                  isLeft: false),
              const Spacer(flex: 1),
              ScanButton(
                  label: "Image",
                  icon: const Icon(
                    Icons.image_outlined,
                    size: 50.0,
                    color: Color(0xfff69036),
                  ),
                  onPress: () {},
                  isLeft: true),
              const Spacer(flex: 1),
              ScanButton(
                  label: "Camera",
                  icon: const Icon(
                    Icons.camera_outlined,
                    size: 50.0,
                    color: Color(0xfff69036),
                  ),
                  onPress: () {
                    scanCamera();
                  },
                  isLeft: false),
              const Spacer(flex: 1),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20.0, bottom: 32.0),
                decoration: const BoxDecoration(
                  color: Color(0xfff69036),
                ),
                child: Container(
                  height: 52.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Insert tab buttons here",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
