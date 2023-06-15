// ignore_for_file: prefer_const_constructors
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:flutter_application_1/screens/search_page.dart';

class QPage extends StatefulWidget {
  final List<Map> questions;

  const QPage({super.key, required this.questions});

  @override
  State<QPage> createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  int _currentQIdx = 0;

  void nextQuestion() {
    if (!(_currentQIdx >= 0)) return;

    int newIndex = _currentQIdx + 1;
    if (newIndex >= widget.questions.length) return;

    // print("Go to next question: $newIndex");

    setState(() {
      _currentQIdx = newIndex;
    });
  }

  void prevQuestion() {
    if (!(_currentQIdx >= 0)) return;

    int newIndex = _currentQIdx - 1;
    if (newIndex < 0) return;

    // print("Go to previous question: $newIndex");

    setState(() {
      _currentQIdx = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    var question = widget.questions[_currentQIdx];
    final String questionStr = question["question"];
    final List<String> choices =
        (question["choices"] as List).map((e) => e as String).toList();
    var answerIndex = question["answer_index"];
    final bool multiChoice = answerIndex is! int;
    if (multiChoice) {
      answerIndex = (answerIndex as List).map((e) => e as int).toList();
    }

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
                          child: BlurryContainer(
                            width: MediaQuery.of(context).size.width,
                            height: (230 + 100 * choices.length).toDouble(),
                            borderRadius: BorderRadius.circular(35),
                            color: MyColors.blue,
                            child: Column(
                              children: [
                                SizedBox(height: 115),
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: prevQuestion,
                                        child: MyIcons.arrowleft()),
                                    Expanded(child: Container()),
                                    InkWell(
                                        onTap: nextQuestion,
                                        child: RotatedBox(
                                            quarterTurns: 2,
                                            child: MyIcons.arrowleft())),
                                  ], //children
                                ),
                                BlurryContainer(
                                  elevation: 10,
                                  blur: 40,
                                  borderRadius: BorderRadius.circular(35),
                                  width: double.infinity,
                                  height: 95,
                                  color: MyColors.yellow.withOpacity(0.45),
                                  padding: EdgeInsets.all(15),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      questionStr,
                                      style: FontStyles.questions,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Expanded(
                                  child: ListView(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 20),
                                    children: [
                                      Column(
                                        children: choices
                                            .map((e) => Column(children: [
                                                  SizedBox(height: 10),
                                                  BlurryContainer(
                                                    width: double.infinity,
                                                    height: 95,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    color: MyColors.darkBlue
                                                        .withOpacity(0.45),
                                                    child: Center(
                                                      child: Text(
                                                        e,
                                                        style: FontStyles.subs,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ]))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                              children: [
                                SizedBox(height: 15),
                                Row(
                                  children: const [
                                    SizedBox(width: 25),
                                    Text(
                                      "Let's Test Your",
                                      style: FontStyles.bigtitle,
                                    ),
                                    SizedBox(width: 30),
                                  ],
                                ),
                                Row(
                                  children: const [
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
