// import 'package:blurrycontainer/blurrycontainer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/services/question_manager.dart';

// import '../screens/mycolors.dart';
// import '../screens/myfonts.dart';
// import '../screens/myicons.dart';

// class QPageInner extends StatefulWidget {
//   final int currentQIdx;
//   final void Function() prevQuestion;
//   final void Function() nextQuestion;

//   const QPageInner(
//       {Key? key,
//       required this.currentQIdx,
//       required this.prevQuestion,
//       required this.nextQuestion})
//       : super(key: key);

//   @override
//   State<QPageInner> createState() => _QPageInnerState();

//   static Text getQuestionStrText(String questionStr) => Text(
//         questionStr,
//         style: FontStyles.questions,
//         textAlign: TextAlign.center,
//       );

//   static FutureBuilder<String> getQuestionStrFutureText(
//           Future<String> questionStr, String fallback) =>
//       FutureBuilder(
//           future: questionStr,
//           builder: (futureContext, snapshot) {
//             int state = 2;

//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 break;
//               default:
//                 if (snapshot.hasError) {
//                   state = 0;
//                 } else if (snapshot.hasData) {
//                   state = 1;
//                 }
//                 break;
//             }

//             switch (state) {
//               case 0:
//                 throw snapshot.error!;
//               case 1:
//                 return getQuestionStrText(snapshot.data!);
//               default:
//                 return getQuestionStrText(fallback);
//             }
//           });
// }

// class _QPageInnerState extends State<QPageInner> {
//   late Future<String> _questionStr;
//   late Future<List<String>> _choices;
//   int _currentQIdx = -1;

//   _reloadQuestion() /* async */ {
//     int currentQIdx = widget.currentQIdx;
//     if (_currentQIdx == currentQIdx) return;

//     /* QuestMgr questMgr = await QuestMgr.createSingleton(); */
//     // QuestMgr should have already been created by the time QPage is
//     QuestMgr questMgr = QuestMgr.instance()!;

//     setState(() {
//       _questionStr = questMgr.getQuestion(currentQIdx);
//       _choices = questMgr.getQuestionChoices(currentQIdx);
//       _currentQIdx = currentQIdx;
//     });
//   }

//   FutureBuilder<String> get _questionStrText {
//     int currentQIdx = widget.currentQIdx;
//     return QPageInner.getQuestionStrFutureText(
//         _questionStr, "Loading question ${currentQIdx + 1}...");
//   }

//   BlurryContainer get _questionStrBlurryContainer => BlurryContainer(
//         elevation: 10,
//         blur: 40,
//         borderRadius: BorderRadius.circular(35),
//         width: double.infinity,
//         height: 95,
//         color: MyColors.yellow.withOpacity(0.45),
//         padding: const EdgeInsets.all(15),
//         child: Align(
//           alignment: Alignment.center,
//           child: _questionStrText,
//         ),
//       );

//   Expanded _getChoicesListView(List<String> choices) => Expanded(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
//           children: [
//             Column(
//               children: choices
//                   .map((e) => Column(children: [
//                         const SizedBox(height: 10),
//                         BlurryContainer(
//                           width: double.infinity,
//                           height: 95,
//                           borderRadius: BorderRadius.circular(35),
//                           color: MyColors.darkBlue.withOpacity(0.45),
//                           child: Center(
//                             child: Text(
//                               e,
//                               style: FontStyles.subs,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ]))
//                   .toList(),
//             ),
//           ],
//         ),
//       );

//   BlurryContainer _getBody(List<String>? choices) => BlurryContainer(
//         width: MediaQuery.of(context).size.width,
//         height: (230 + (choices != null ? 100 * choices.length : 0)).toDouble(),
//         borderRadius: BorderRadius.circular(35),
//         color: MyColors.blue,
//         child: Column(
//           children: [
//             const SizedBox(height: 115),
//             Row(
//               children: [
//                 InkWell(onTap: widget.prevQuestion, child: MyIcons.arrowleft()),
//                 Expanded(child: Container()),
//                 InkWell(
//                     onTap: widget.nextQuestion,
//                     child: RotatedBox(
//                         quarterTurns: 2, child: MyIcons.arrowleft())),
//               ], //children
//             ),
//             _questionStrBlurryContainer,
//             const SizedBox(height: 5),
//             choices != null
//                 ? _getChoicesListView(choices)
//                 : const SizedBox.shrink(),
//           ],
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     _reloadQuestion();
//     return FutureBuilder<List<String>>(
//         future: _choices,
//         builder: (futureContext, snapshot) {
//           int state = 2;

//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               break;
//             default:
//               if (snapshot.hasError) {
//                 state = 0;
//               } else if (snapshot.hasData) {
//                 state = 1;
//               }
//               break;
//           }

//           switch (state) {
//             case 0:
//               throw snapshot.error!;
//             case 1:
//               return _getBody(snapshot.data!);
//             default:
//               return _getBody(null);
//           }
//         });
//   }
// }

// ignore_for_file: unused_import, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_application_1/screens/question_page.dart';

import '../screens/mycolors.dart';
import '../screens/myfonts.dart';
import '../screens/myicons.dart';
import '../services/question_manager.dart';

class QPageInner extends StatefulWidget {
  final Function(double) onScoreUpdated; // Add a callback for score update
  final int currentQIdx;
  final VoidCallback prevQuestion;
  final VoidCallback nextQuestion;

  const QPageInner({
    Key? key,
    required this.currentQIdx,
    required this.prevQuestion,
    required this.nextQuestion,
    required this.onScoreUpdated, // Require the callback in the constructor
  }) : super(key: key);

  @override
  State<QPageInner> createState() => _QPageInnerState();

  static Widget getQuestionStrText(String questionStr) {
    // This is a static method now and can be called from outside the class.
    return Text(
      questionStr,
      style: FontStyles.questions,
      textAlign: TextAlign.center,
    );
  }
}

class _QPageInnerState extends State<QPageInner> {
  late Future<String> _questionStr;
  late Future<List<String>> _choices;
  int? _selectedIndex; // Track the selected index
  bool? _isCorrect; // Track if the selected answer is correct

  @override
  void initState() {
    super.initState();
    _loadQuestionData();
  }

  void _handleChoiceTap(int currQIdx, int index) async {
    QuestMgr? questMgr = QuestMgr.instance();

    // Determine if the selected answer is correct (this may not be needed if you don't use it later).
    bool isCorrect = index == await questMgr!.getCorrectAnswerIndex(currQIdx);

    setState(() {
      _selectedIndex = index;
      _isCorrect = isCorrect;
    });

    // Update the score based on the selected answer.
    questMgr.selectAnswer(currQIdx, index);
    widget.onScoreUpdated(questMgr.getScore()); // Update the score display.
  }

  @override
  void didUpdateWidget(QPageInner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentQIdx != oldWidget.currentQIdx) {
      _loadQuestionData();
      _resetChoiceState();
    }
  }

  void _resetChoiceState() {
    setState(() {
      _selectedIndex = null;
      _isCorrect = null;
    });
  }

  Color _getChoiceColor(int index) {
    // If nothing or another index is selected, return default color
    if (_selectedIndex == null || _selectedIndex != index)
      return MyColors.darkBlue.withOpacity(0.45);

    // Return colors based on the correctness of the selection
    return _isCorrect == true ? MyColors.yellow : MyColors.pink;
  }

  void _loadQuestionData() {
    QuestMgr? questMgr = QuestMgr.instance();
    _questionStr = questMgr!.getQuestion(widget.currentQIdx);
    _choices = questMgr.getQuestionChoices(widget.currentQIdx);
  }

  Widget _buildQuestionText(String questionStr) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BlurryContainer(
          blur: 40,
          borderRadius: BorderRadius.circular(35),
          color: MyColors.yellow.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(
              horizontal: 48), // Adjust padding to make space for the buttons
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.25,
            alignment: Alignment.center,
            child: Text(
              questionStr,
              style: FontStyles.questions,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          left: -15, // Adjust the position as needed
          top: 0,
          bottom: 0,
          child: CircleAvatar(
            backgroundColor:
                Colors.white.withOpacity(0.8), // Adjust the opacity as needed
            child: IconButton(
              icon: MyIcons.arrowleft(), // Use Material Icons
              onPressed: widget.prevQuestion,
            ),
          ),
        ),
        Positioned(
          right: -15, // Adjust the position as needed
          top: 0,
          bottom: 0,
          child: CircleAvatar(
            backgroundColor:
                Colors.white.withOpacity(0.8), // Adjust the opacity as needed
            child: IconButton(
              icon: RotatedBox(
                  quarterTurns: 2,
                  child: MyIcons.arrowleft()), // Use Material Icons
              onPressed: widget.nextQuestion,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChoice(String choice, int index) {
    return InkWell(
      onTap: () => _handleChoiceTap(widget.currentQIdx, index),
      child: BlurryContainer(
        width: double.infinity,
        height: 95,
        borderRadius: BorderRadius.circular(35),
        color:
            _getChoiceColor(index), // Use the dynamic color based on selection
        child: Center(
          child: Text(
            choice,
            style: FontStyles.subs,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildChoicesListView(List<String> choices) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: choices.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: _buildChoice(choices[index],
              index), // Build each choice with the _buildChoice method
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.009),
          FutureBuilder<String>(
            future: _questionStr,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return _buildQuestionText(snapshot.data!);
              } else {
                return Text('No question available');
              }
            },
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<String>>(
            future: _choices,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Expanded(child: _buildChoicesListView(snapshot.data!));
              } else {
                return Text('No choices available');
              }
            },
          ),
        ],
      ),
    );
  }
}
