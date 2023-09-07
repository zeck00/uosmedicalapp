// ignore_for_file: prefer_const_constructors
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:flutter_application_1/screens/search_page.dart';
import 'package:flutter_application_1/services/question_page_inner.dart';

import '../services/question_manager.dart';

class QPage extends StatefulWidget {
  const QPage({super.key});

  @override
  State<QPage> createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  QuestMgr? _questMgr;
  late int _currentQIdx;

  createQuestMgrInstance() async {
    assert(_questMgr == null);

    QuestMgr questMgr = await QuestMgr.createSingleton();
    int currentQIdx = (await questMgr.getQuestionNum()) > 0 ? 0 : -1;

    setState(() {
      _questMgr = questMgr;
      _currentQIdx = currentQIdx;
    });
  }

  @override
  initState() {
    super.initState();
    createQuestMgrInstance();
  }

  void _nextQuestion() async {
    assert(_questMgr != null);
    if (_currentQIdx == -1) return;

    int newIndex = _currentQIdx + 1;
    if (newIndex >= await _questMgr!.getQuestionNum()) return;

    // print("Go to next question: $newIndex");

    setState(() {
      _currentQIdx = newIndex;
    });
  }

  void _prevQuestion() {
    assert(_questMgr != null);
    if (_currentQIdx == -1) return;

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
                          child: _questMgr != null && _currentQIdx != -1
                              ? QPageInner(
                                  questMgr: _questMgr!,
                                  currentQIdx: _currentQIdx,
                                  prevQuestion: _prevQuestion,
                                  nextQuestion: _nextQuestion)
                              : SizedBox.shrink(),
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
