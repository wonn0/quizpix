import 'package:flutter/material.dart';
import 'package:quizpix/widgets/custom_arc.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {super.key,
      required this.usernameController,
      required this.usertitleController,
      required this.passwordController,
      required this.newpasswordController,
      required this.conpasswordController});

  final TextEditingController usernameController;
  final TextEditingController usertitleController;
  final TextEditingController passwordController;
  final TextEditingController newpasswordController;
  final TextEditingController conpasswordController;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _image;
  final picker = ImagePicker();
  String? errorCode;

  String showErrorText(String errorCode) {
    switch (errorCode) {
      case "noPassword":
        return "Please fill 'Password' field to change password";
      case "noNewPassword":
        return "Please fill 'New Password' field to change password";
      case "noConPassword":
        return "Please fill 'Confirm Password' field to change password";
      case "wrongNewPass":
        return "New passwords don't match";
      default:
        return "Please try again";
    }
  }

  bool verifyEditProfile() {
    if (widget.passwordController.text.isNotEmpty ||
        widget.newpasswordController.text.isNotEmpty ||
        widget.conpasswordController.text.isNotEmpty) {
      if (widget.passwordController.text.isEmpty) {
        setState(() {
          errorCode = "noPassword";
        });
        return false;
      } else if (widget.newpasswordController.text.isEmpty) {
        setState(() {
          errorCode = "noNewPassword";
        });
        return false;
      } else if (widget.conpasswordController.text.isEmpty) {
        setState(() {
          errorCode = "noConPassword";
        });
        return false;
      } else if (widget.newpasswordController.text !=
          widget.conpasswordController.text) {
        setState(() {
          errorCode = "wrongNewPass";
        });
        return false;
      }
    }
    return true;
  }

  Future getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
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
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 16.0, right: 0.0, bottom: 0.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Color(0xff6d5271),
                      ),
                      onPressed: () {
                        widget.usernameController.text = "";
                        widget.usertitleController.text = "";
                        widget.passwordController.text = "";
                        widget.newpasswordController.text = "";
                        widget.conpasswordController.text = "";
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 16.0, right: 20.0),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff69036),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0, bottom: 16.0),
                    child: const Text(
                      "Current Profile Picture",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff69036),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      _image == null
                          ? Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 8,
                                      offset: const Offset(8, 8),
                                    ),
                                  ]),
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user1.jpg'),
                                radius: 100.0,
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 8,
                                      offset: const Offset(8, 8),
                                    ),
                                  ]),
                              child: CircleAvatar(
                                backgroundImage: FileImage(File(_image!.path)),
                                radius: 100.0,
                              ),
                            ),
                      InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: const CustomArc(
                          diameter: 200.0,
                          text: Text(
                            "Change Picture",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: QTextField(
                      label: "Username",
                      textController: widget.usernameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "User Title",
                      textController: widget.usertitleController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "Password",
                      textController: widget.passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "New Password",
                      textController: widget.newpasswordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "Confirm Password",
                      textController: widget.conpasswordController,
                    ),
                  ),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: errorCode == null
                          ? Container()
                          : Text(
                              showErrorText(errorCode!),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffd0342c),
                                letterSpacing: 0.2,
                                wordSpacing: 0.5,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 4.0, right: 20.0, bottom: 32.0),
                      child: QButton(
                          label: "Update Profile",
                          onPress: () {
                            if (verifyEditProfile()) {
                              // Navigator.pop(context);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
