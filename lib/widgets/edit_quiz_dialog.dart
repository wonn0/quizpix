import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizpix/helpers/quiz.dart';
import 'package:quizpix/models/quiz.dart';

class EditQuizDialog extends StatefulWidget {
  // const EditQuizDialog({super.key, required this.image, required this.title});
  const EditQuizDialog({super.key, required this.quiz, required this.onPop});

  // final Image image;
  // final String title;
  final Quiz quiz;
  final VoidCallback onPop;

  @override
  State<EditQuizDialog> createState() => _EditQuizDialogState();
}

class _EditQuizDialogState extends State<EditQuizDialog> {
  XFile? _image;
  final picker = ImagePicker();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.quiz.title;
  }

  Future getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        //print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      contentPadding: const EdgeInsets.only(
          left: 20.0, top: 20.0, right: 20.0, bottom: 8.0),
      actionsPadding: const EdgeInsets.only(right: 20.0, bottom: 8.0),
      title: const Text(
        'Edit Quiz Details',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color: Color(0xfff69036),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: const Text(
                'Image',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xfff69036),
                ),
              ),
            ),
            Container(
                height: 160.0,
                width: 160.0,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Color(0xffd9d9d9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: _image != null
                    ? Image(
                        image: FileImage(File(_image!.path)),
                      )
                    : widget.quiz.image != null
                        ? Image.network(widget.quiz.image!)
                        : Image.asset('assets/images/book.png')),
            InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
                width: 160.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                decoration: const BoxDecoration(
                  color: Color(0xfff69036),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Change Picture',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: const Text(
                'Title',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xfff69036),
                ),
              ),
            ),
            TextField(
              controller: titleController,
              style: const TextStyle(
                color: Color(0xff6d5271),
                fontSize: 16.0,
              ),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff6d5271),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff6d5271),
                  ),
                ),
                filled: false,
                labelText: 'Title',
                hintText: 'Please enter a valid title',
                labelStyle: TextStyle(
                  color: Color(0xff909090),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff909090),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            print('Save button pressed');
            print('TitleController.text: ${titleController.text}');
            print('_image: $_image');

            String title = titleController.text;
            String? img = _image?.path;

            Quiz temp = Quiz(widget.quiz.url, widget.quiz.user,
                widget.quiz.username, img, title, widget.quiz.isShared);
            if (img == null) {
              updateQuiz(temp).then((response) {
                widget.onPop();
                Navigator.pop(context);
              });
            } else {
              updateQuizProfile(temp).then((response) {
                widget.onPop();
                Navigator.pop(context);
              });
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(32, 32),
            backgroundColor: const Color(0xfff69036),
            elevation: 4.0,
          ),
          child: const Text('Save', style: TextStyle(fontSize: 16.0)),
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
