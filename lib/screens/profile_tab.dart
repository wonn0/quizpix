import 'package:flutter/material.dart';
import 'package:quizpix/widgets/pro_card.dart';
import 'package:quizpix/widgets/q_button_outline.dart';
import 'package:quizpix/widgets/stat_card.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key, required this.username, required this.title});

  final String username;
  final String title;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
                SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        height: 180.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: AssetImage('assets/images/user1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(30.0, 30.0),
                            backgroundColor: const Color(0xffd3d3d3),
                            shape: CircleBorder(),
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 16.0,
                            color: const Color(0xff909090),
                          ),
                        ),
                      ),
                      Container(
                        height: 80.0,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 40.0, top: 120.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            bottomLeft: Radius.circular(80),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(0.0, 4.0),
                              spreadRadius: 1,
                              blurRadius: 12,
                            ),
                          ],
                          color: const Color(0xfffafafa),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.username,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xfff69036),
                                ),
                              ),
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color(0x996d5271),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Statistics",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xfff69036),
                    ),
                  ),
                ),
                Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatCard(type: 'quiz', value: 5),
                    StatCard(type: 'score', value: 144),
                  ],
                ),
                Spacer(flex: 2),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ProCard(),
                ),
                Spacer(flex: 2),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: QButtonOutline(
                      label: "Sign Out",
                      onPress: () {
                        Navigator.pushNamed(context, '/');
                      }),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ));
  }
}
