import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizpix/screens/scan_confirmation.dart';
import 'package:quizpix/widgets/scan_button.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';


main() async {
  runApp(const MaterialApp(home: ScanTab()));
}

class ScanTab extends StatefulWidget {
  const ScanTab({super.key});

  @override
  State<ScanTab> createState() => _ScanTabState();
}

class _ScanTabState extends State<ScanTab> {
  String _text = '';
  late XFile _image;
  late List<XFile> _images;
  final picker = ImagePicker();
  bool _load = false;

  bool isLoading = false;

  String _fileContent = '';

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'docx', 'pdf'],
      ).then((result) async {
        if (result!.files.isNotEmpty) {
          // FOR TXT FILES
            if (result.files.first.extension == 'txt') {
              try {
                Directory appDir = Directory.systemTemp;
                print('This is a appDir {$appDir}');

                String fileContent;
                if (Platform.isAndroid) {
                  final file = File(result.files.first.path!);
                  fileContent = await file.readAsString();
                  print('Print successfull');
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanConfirmation(text: fileContent)));
                  print('Hello');
                } else {
                  fileContent = await File(result.files.first.path!).readAsString();
                }

                setState(() {
                  _fileContent = fileContent;
                });

                // save the file in app's documents directory
                final directory = await getApplicationDocumentsDirectory();
                final fileName = result.files.first.path!.split('/').last;
                final file = File('${directory.path}/$fileName');
                await file.writeAsString(fileContent);
              } catch (e) {
                print('Error while picking the file: $e');
              }
            }
          // FOR PDF FILES
          else if (result.files.first.extension == 'pdf') {
            Future<String> getPDFtext(String path) async {
              String text = "";
              text = await ReadPdfText.getPDFtext(path);
              return text;
            }

            final text = await getPDFtext(result.files.first.path!);
            // ignore: use_build_context_synchronously
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScanConfirmation(text: text)));
          }
        } else {
          print('No files were selected');
        }
      }).catchError((e) {
        // Handle any errors that might occur while trying to pick a file
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
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
            color: Color(0xfffafafa),
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 40.0, bottom: 40.0),
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
                        onPress: () {
                          pickFile();
                        },
                        isLeft: true),
                    const Spacer(flex: 1),
                    ScanButton(
                        label: "Input",
                        icon: const Icon(
                          Icons.edit_note_outlined,
                          size: 50.0,
                          color: Color(0xfff69036),
                        ),
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ScanConfirmation(
                                  title: "Input your reading material")));
                        },
                        isLeft: false),
                    const Spacer(flex: 1),
                    ScanButton(
                        label: "Image",
                        icon: const Icon(
                          Icons.image_outlined,
                          size: 50.0,
                          color: Color(0xfff69036),
                        ),
                        onPress: () {
                          getImages();
                        },
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
                          getCamera();
                        },
                        isLeft: false),
                    const Spacer(flex: 1),
                    _load == true
                        ? SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.file(
                              File(_image.path),
                              fit: BoxFit.fitWidth,
                            ))
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future scanTextFromImages() async {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    for (final img in _images) {
      final FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(File(img.path));
      final TextRecognizer textRecognizer =
          FirebaseVision.instance.textRecognizer();
      final VisionText visionText =
          await textRecognizer.processImage(visionImage);

      for (TextBlock block in visionText.blocks) {
        for (TextLine line in block.lines) {
          _text += '${line.text}\n';
        }
      }
    }

    navigator.pop();
    navigator.push(
        MaterialPageRoute(builder: (context) => ScanConfirmation(text: _text)));
  }

  Future getImages() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    setState(() {
      if (pickedFiles.isNotEmpty) {
        _images = pickedFiles;
        _load = false;
        scanTextFromImages();
      } else {
        //print('No image selected');
      }
    });
  }

  // Future<String> readTextFile() async {
  //   try {
  //     File file = File('lib/samples/Sample.txt');
  //     String contents = await file.readAsString();
  //     print(contents);
  //     return contents;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  Future scanTextFromCamera() async {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
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
        _text += '${line.text!}\n';
      }
    }

    navigator.pop();
    navigator.push(
        MaterialPageRoute(builder: (context) => ScanConfirmation(text: _text)));
  }

  Future getCamera() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        _load = false;
        scanTextFromCamera();
      } else {
        //print('No image selected');
      }
    });
  }
}
