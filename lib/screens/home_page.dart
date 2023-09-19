// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_application_1/screens/question_page.dart';
import 'package:flutter_application_1/services/question_manager.dart';
import 'package:flutter_application_1/services/question_page_inner.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum _HasQuestions { notLoaded, no, yes }

class _HomePageState extends State<HomePage> {
  _HasQuestions _hasQuestions = _HasQuestions.notLoaded;
  late int _questionNum;
  late String _firstQuestion;

  loadFirstQuestion() async {
    if (_hasQuestions != _HasQuestions.notLoaded) {
      return;
    }

    QuestMgr questMgr = await QuestMgr.createSingleton();
    int questionNum = questMgr.getQuestionNum();

    if (questionNum > 0) {
      String firstQuestion = await questMgr.getQuestion(0);
      setState(() {
        _hasQuestions = _HasQuestions.yes;
        _questionNum = questionNum;
        _firstQuestion = firstQuestion;
      });
    } else {
      setState(() {
        _hasQuestions = _HasQuestions.no;
        _questionNum = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadFirstQuestion();
    return Scaffold(
      backgroundColor: MyColors.green,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"), fit: BoxFit.cover),
        ),
        child: Center(
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
                  const SizedBox(height: 30),
                  BlurryContainer(
                    blur: 100,
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    color: MyColors.darkBlue.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Continue",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Where You",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Left...",
                                    style: FontStyles.categories,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              InkWell(
                                child: MyIcons.arrowcircle(),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlurryContainer(
                    blur: 100,
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    color: MyColors.darkBlue.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 7, right: 10, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Explore the",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Course Material",
                                    style: FontStyles.categories,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              MyIcons.arrowcircle()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlurryContainer(
                    blur: 100,
                    width: MediaQuery.of(context).size.width,
                    height: 395,
                    color: MyColors.darkBlue.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 7, right: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Test Your",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Knowledge",
                                    style: FontStyles.categories,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              _hasQuestions == _HasQuestions.yes
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => QPage(
                                                  questionNum: _questionNum)),
                                        );
                                      },
                                      child: MyIcons.arrowcircle(),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(height: 15),
<<<<<<< HEAD
                          InkWell(
                            child: BlurryContainer(
                              blur: 100,
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              color: MyColors.yellow.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(35),
                              elevation: 10,
                              child: Center(
                                child: Text(
                                  _questions.isNotEmpty
                                      ? getQuestionText(_questions[0])
                                      : "Loading questions...",
                                  style: FontStyles.questions,
                                  textAlign: TextAlign.center,
                                ),
                              ),
=======
                          BlurryContainer(
                            blur: 100,
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            color: MyColors.yellow.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(35),
                            elevation: 10,
                            child: Center(
                              child: _hasQuestions == _HasQuestions.notLoaded
                                  ? QPageInner.getQuestionStrText(
                                      "Loading questions...")
                                  : (_hasQuestions == _HasQuestions.yes
                                      ? QPageInner.getQuestionStrText(
                                          _firstQuestion)
                                      : QPageInner.getQuestionStrText(
                                          "No questions available.")),
>>>>>>> origin/questions-from-server
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QPage(questions: _questions)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  BottomNav(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
