import 'package:flutter/material.dart';
import 'package:quizpix/widgets/confirm_dialog.dart';
import 'package:quizpix/widgets/custom_arc.dart';
import 'package:quizpix/widgets/q_button.dart';
import 'package:quizpix/widgets/q_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/user.dart';
import '../helpers/user.dart';
import '../globals/globals.dart';

import 'package:quizpix/widgets/q_toast.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _image;
  final picker = ImagePicker();

  TextEditingController usertitleController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();

  bool verifyEditProfile() {
    // if (passwordController.text.isNotEmpty ||
    //     newpasswordController.text.isNotEmpty ||
    //     conpasswordController.text.isNotEmpty) {
    //   if (passwordController.text.isEmpty) {
    //     showQToast("Please input password to change it", true);
    //     return false;
    //   } else if (newpasswordController.text.isEmpty) {
    //     showQToast("New password is not defined", true);
    //     return false;
    //   } else if (conpasswordController.text.isEmpty) {
    //     showQToast("New password is unconfirmed", true);
    //     return false;
    //   } else if (newpasswordController.text != conpasswordController.text) {
    //     showQToast("New passwords don't match", true);
    //     return false;
    //   }
    // }
    // return true;
    if (newpasswordController.text.isNotEmpty ||
        conpasswordController.text.isNotEmpty) {
      if (newpasswordController.text.isEmpty) {
        showQToast("New password is not defined", true);
        return false;
      } else if (conpasswordController.text.isEmpty) {
        showQToast("New password is unconfirmed", true);
        return false;
      } else if (newpasswordController.text != conpasswordController.text) {
        showQToast("New passwords don't match", true);
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
        //print('No image selected');
      }
    });
  }

  void confirmEditProfile(NavigatorState confirmContext) {
    confirmContext.pop();
    String password =
        newpasswordController.text.isNotEmpty
            ? newpasswordController.text
            : "";
    String? img =
        _image == null ? null : _image!.path;
    User temp = User(
      localDetails.url,
      localDetails.username,
      password,
      localDetails.email,
      usertitleController.text,
      img,
      true,
      localDetails.quizzesMade,
      localDetails.totalScore,
      "regular",
      localDetails.items
    );
    FocusManager.instance.primaryFocus?.unfocus();
    if (img == null) {
      updateUserDetails(context, temp)
          .then((response) {
        showQToast(
            "Successfully edited profile", false);
        Navigator.pop(context);
      });
    } else {
      updateUserProfile(context, temp)
          .then((response) {
        showQToast(
            "Successfully edited profile", false);
        Navigator.pop(context);
      });
    }
}

  Future<dynamic> displayConfirmDialog(BuildContext context) async {
    late NavigatorState confirmContext;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        confirmContext = Navigator.of(context);
        return ConfirmDialog(
          confirm: confirmEditProfile,
          confirmContext: confirmContext,
          action: "Edit Profile",
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //pre populate text field
    usertitleController.text = localDetails.title;
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
                      _image != null
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
                              child: CircleAvatar(
                                backgroundImage: FileImage(File(_image!.path)),
                                radius: 100.0,
                              ),
                            )
                          : localDetails.profilePicture == null
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
                                        AssetImage('assets/images/df-pp.jpg'),
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
                                    backgroundImage: NetworkImage(
                                        localDetails.profilePicture!),
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
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "User Title",
                      textController: usertitleController,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 20.0, top: 8.0, right: 20.0),
                  //   child: QTextField(
                  //     label: "Password",
                  //     textController: passwordController,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "New Password",
                      textController: newpasswordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: QTextField(
                      label: "Confirm Password",
                      textController: conpasswordController,
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
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20.0, right: 20.0, bottom: 32.0),
                      child: QButton(
                          label: "Update Profile",
                          onPress: () {
                            if (verifyEditProfile()) {
                              displayConfirmDialog(context);
                              FocusManager.instance.primaryFocus?.unfocus();
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
