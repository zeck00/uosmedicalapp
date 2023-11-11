import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_application_1/screens/question_page.dart';
import 'package:flutter_application_1/services/question_manager.dart';
import 'search_page.dart';
import 'package:flutter_application_1/services/question_page_inner.dart';

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
  late List<String> _questions;

  @override
  void initState() {
    super.initState();
    _questions = [];
    loadFirstQuestion();
  }

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
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.green,
      body: Container(
        height: screenSize.height, // Set the container height
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: BlurryContainer(
              borderRadius: BorderRadius.circular(35),
              width: screenSize.width * 0.9,
              // You might want to adjust the height based on the content
              blur: 25,
              color: MyColors.white.withAlpha(100),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Fit the content size
                  children: [
                    TopBar(),
                    const SizedBox(height: 30),
                    BlurryContainer(
                      blur: 100,
                      width: screenSize.width,
                      height: 120,
                      color: MyColors.darkBlue.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Continue",
                                        style: FontStyles.categories),
                                    Text("Where You",
                                        style: FontStyles.categories),
                                    Text("Left...",
                                        style: FontStyles.categories),
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
                      width: screenSize.width,
                      height: screenSize.height * 0.6,
                      color: MyColors.darkBlue.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Test Your",
                                        style: FontStyles.categories),
                                    Text("Knowledge",
                                        style: FontStyles.categories),
                                  ],
                                ),
                                Expanded(child: Container()),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QPage(questionNum: _questionNum)),
                                    );
                                  },
                                  child: MyIcons.arrowcircle(),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            BlurryContainer(
                              blur: 100,
                              width: screenSize.width,
                              height: screenSize.height * 0.475,
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
                              ),
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
      ),
    );
  }
}
