// ignore_for_file: prefer_const_constructors
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:flutter_application_1/screens/search_page.dart';

import '../services/question_manager.dart';

class QPage extends StatefulWidget {
  const QPage({super.key});

  @override
  State<QPage> createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  QuestMgr? _questMgr;
  int _currentQIdx = 0;

  String? get questionStr => _questMgr?.getQuestion(_currentQIdx);
  List<String>? get choices => _questMgr?.getQuestionChoices(_currentQIdx);

  createQuestMgrInstance() async {
    if (_questMgr != null) {
      return;
    }

    var questMgr = await QuestMgr.createSingleton();
    setState(() {
      _questMgr = questMgr;
    });
  }

  int get choiceNum => choices == null ? 0 : choices!.length;

  void nextQuestion() {
    assert(_questMgr != null);

    int newIndex = _currentQIdx + 1;
    if (newIndex >= _questMgr!.questionNum) return;

    // print("Go to next question: $newIndex");

    setState(() {
      _currentQIdx = newIndex;
    });
  }

  void prevQuestion() {
    assert(_questMgr != null);

    int newIndex = _currentQIdx - 1;
    if (newIndex < 0) return;

    // print("Go to previous question: $newIndex");

    setState(() {
      _currentQIdx = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    createQuestMgrInstance();
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
                            height: (230 + 100 * choiceNum).toDouble(),
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
                                      questionStr != null
                                          ? questionStr!
                                          : "Loading question...",
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
                                      choices != null
                                          ? Column(
                                              children: choices!
                                                  .map((e) => Column(children: [
                                                        SizedBox(height: 10),
                                                        BlurryContainer(
                                                          width:
                                                              double.infinity,
                                                          height: 95,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(35),
                                                          color: MyColors
                                                              .darkBlue
                                                              .withOpacity(
                                                                  0.45),
                                                          child: Center(
                                                            child: Text(
                                                              e,
                                                              style: FontStyles
                                                                  .subs,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ]))
                                                  .toList(),
                                            )
                                          : const Column(),
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
