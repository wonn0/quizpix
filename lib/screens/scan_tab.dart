import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizpix/screens/scan_confirmation.dart';
import 'package:quizpix/widgets/scan_button.dart';

import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

main() async {
  runApp(const MaterialApp(home: ScanTab()));
}

class ScanTab extends StatefulWidget {
  const ScanTab({super.key});

  @override
  _ScanTabState createState() => _ScanTabState();
}

class _ScanTabState extends State<ScanTab> {
  String _text = '';
  late XFile _image;
  final picker = ImagePicker();
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfffafafa),
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
                    getImage();
                  },
                  isLeft: false),
              const Spacer(flex: 1),
              _load == true
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: _image != null
                          ? Image.file(
                              File(_image.path),
                              fit: BoxFit.fitWidth,
                            )
                          : Container(),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Future scanText() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }

    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ScanConfirmation(text: _text)));
  }

  Future getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        _load = false;
        scanText();
      } else {
        print('No image selected');
      }
    });
  }
}
