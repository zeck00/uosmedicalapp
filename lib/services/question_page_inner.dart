import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/question_manager.dart';

import '../screens/mycolors.dart';
import '../screens/myfonts.dart';
import '../screens/myicons.dart';

class QPageInner extends StatefulWidget {
  final QuestMgr questMgr;
  final int currentQIdx;
  final void Function() prevQuestion;
  final void Function() nextQuestion;

  const QPageInner(
      {Key? key,
      required this.questMgr,
      required this.currentQIdx,
      required this.prevQuestion,
      required this.nextQuestion})
      : super(key: key);

  @override
  State<QPageInner> createState() => _QPageInnerState();

  static Text getQuestionStrText(String questionStr) => Text(
        questionStr,
        style: FontStyles.questions,
        textAlign: TextAlign.center,
      );

  static FutureBuilder<String> getQuestionStrFutureText(
          Future<String> questionStr, String fallback) =>
      FutureBuilder(
          future: questionStr,
          builder: (futureContext, snapshot) {
            int state = 2;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                break;
              default:
                if (snapshot.hasError) {
                  state = 0;
                } else if (snapshot.hasData) {
                  state = 1;
                }
                break;
            }

            switch (state) {
              case 0:
                throw snapshot.error!;
              case 1:
                return getQuestionStrText(snapshot.data!);
              default:
                return getQuestionStrText(fallback);
            }
          });
}

class _QPageInnerState extends State<QPageInner> {
  late Future<String> _questionStr;
  late Future<List<String>> _choices;
  int _currentQIdx = -1;

  _reloadQuestion() {
    int currentQIdx = widget.currentQIdx;
    if (_currentQIdx == currentQIdx) return;

    QuestMgr questMgr = widget.questMgr;

    setState(() {
      _questionStr = questMgr.getQuestion(currentQIdx);
      _choices = questMgr.getQuestionChoices(currentQIdx);
      _currentQIdx = currentQIdx;
    });
  }

  FutureBuilder<String> get _questionStrText {
    int currentQIdx = widget.currentQIdx;
    return QPageInner.getQuestionStrFutureText(
        _questionStr, "Loading question ${currentQIdx + 1}...");
  }

  BlurryContainer get _questionStrBlurryContainer => BlurryContainer(
        elevation: 10,
        blur: 40,
        borderRadius: BorderRadius.circular(35),
        width: double.infinity,
        height: 95,
        color: MyColors.yellow.withOpacity(0.45),
        padding: const EdgeInsets.all(15),
        child: Align(
          alignment: Alignment.center,
          child: _questionStrText,
        ),
      );

  Expanded _getChoicesListView(List<String> choices) => Expanded(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          children: [
            Column(
              children: choices
                  .map((e) => Column(children: [
                        const SizedBox(height: 10),
                        BlurryContainer(
                          width: double.infinity,
                          height: 95,
                          borderRadius: BorderRadius.circular(35),
                          color: MyColors.darkBlue.withOpacity(0.45),
                          child: Center(
                            child: Text(
                              e,
                              style: FontStyles.subs,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]))
                  .toList(),
            ),
          ],
        ),
      );

  BlurryContainer _getBody(List<String>? choices) => BlurryContainer(
        width: MediaQuery.of(context).size.width,
        height: (230 + (choices != null ? 100 * choices.length : 0)).toDouble(),
        borderRadius: BorderRadius.circular(35),
        color: MyColors.blue,
        child: Column(
          children: [
            const SizedBox(height: 115),
            Row(
              children: [
                InkWell(onTap: widget.prevQuestion, child: MyIcons.arrowleft()),
                Expanded(child: Container()),
                InkWell(
                    onTap: widget.nextQuestion,
                    child: RotatedBox(
                        quarterTurns: 2, child: MyIcons.arrowleft())),
              ], //children
            ),
            _questionStrBlurryContainer,
            const SizedBox(height: 5),
            choices != null
                ? _getChoicesListView(choices)
                : const SizedBox.shrink(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    _reloadQuestion();
    return FutureBuilder<List<String>>(
        future: _choices,
        builder: (futureContext, snapshot) {
          int state = 2;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              break;
            default:
              if (snapshot.hasError) {
                state = 0;
              } else if (snapshot.hasData) {
                state = 1;
              }
              break;
          }

          switch (state) {
            case 0:
              throw snapshot.error!;
            case 1:
              return _getBody(snapshot.data!);
            default:
              return _getBody(null);
          }
        });
  }
}
