// ignore_for_file: prefer_const_constructors
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:flutter_application_1/screens/search_page.dart';
import 'package:flutter_application_1/services/question_page_inner.dart';

class QPage extends StatefulWidget {
  final int questionNum;

  QPage({super.key, required this.questionNum}) {
    assert(questionNum > 0);
  }

  @override
  State<QPage> createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  int _currentQIdx = 0;

  void _nextQuestion() {
    int questionNum = widget.questionNum;
    if (!(questionNum > 0)) return;

    int newIndex = _currentQIdx + 1;
    if (newIndex >= questionNum) return;

    // print("Go to next question: $newIndex");

    setState(() {
      _currentQIdx = newIndex;
    });
  }

  void _prevQuestion() {
    int questionNum = widget.questionNum;
    if (!(questionNum > 0)) return;

    int newIndex = _currentQIdx - 1;
    if (newIndex < 0) return;

    // print("Go to previous question: $newIndex");

    setState(() {
      _currentQIdx = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.green,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: BlurryContainer(
            child: BlurryContainer(
              borderRadius: BorderRadius.circular(35),
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height - 50,
              blur: 25,
              color: MyColors.white.withAlpha(100),
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    TopBar(),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            child: MyIcons.backhome()),
                        Expanded(child: Container()),
                        InkWell(child: MyIcons.qhelparrow()),
                      ],
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Positioned(
                          child: QPageInner(
                                  currentQIdx: _currentQIdx,
                                  prevQuestion: _prevQuestion,
                                  nextQuestion: _nextQuestion),
                        ),
                        Positioned(
                          child: BlurryContainer(
                            elevation: 10,
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            borderRadius: BorderRadius.circular(35),
                            color: MyColors.blue.withOpacity(0.45),
                            blur: 100,
                            child: Column(
                              children: const [
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    SizedBox(width: 25),
                                    Text(
                                      "Let's Test Your",
                                      style: FontStyles.bigtitle,
                                    ),
                                    SizedBox(width: 30),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 45),
                                    Text(
                                      "Knowledge !",
                                      style: FontStyles.bigtitle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    BottomNav()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
