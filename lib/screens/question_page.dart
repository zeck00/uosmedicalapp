import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:flutter_application_1/screens/search_page.dart';
import 'package:flutter_application_1/services/question_page_inner.dart';
import 'package:flutter_application_1/services/question_manager.dart';

class QPage extends StatefulWidget {
  final int questionNum;

  QPage({Key? key, required this.questionNum}) : super(key: key) {
    assert(questionNum > 0);
  }

  @override
  _QPageState createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  int _currentQIdx = 0;
  double _score = 0; // Add a property to track the score

  @override
  void initState() {
    super.initState();
    // Your initialization logic here (if necessary)
  }

  void _updateScore(double newScore) {
    setState(() {
      _score = newScore;
    });
  }

  void _nextQuestion() {
    if (_currentQIdx < widget.questionNum - 1) {
      setState(() {
        _currentQIdx++;
      });
    }
  }

  void _prevQuestion() {
    if (_currentQIdx > 0) {
      setState(() {
        _currentQIdx--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.green,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            child: BlurryContainer(
              borderRadius: BorderRadius.circular(35),
              blur: 25,
              color: MyColors.white.withAlpha(100),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      screenWidth * 0.05, // Responsive horizontal padding
                  vertical: screenHeight * 0.01, // Responsive vertical padding
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.03), // Responsive spacing
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const HomePage())),
                          child: MyIcons.backhome(),
                        ),
                        Expanded(child: Container()),
                        InkWell(child: MyIcons.qhelparrow()),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      "Test Your Knowledge ! ",
                      style: FontStyles.categories,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Score bar added here
                    Container(
                      width: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        color: MyColors.magenta.withAlpha(65),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Score: $_score',
                                style: FontStyles.categories),
                            IconButton(
                              icon:
                                  Icon(Icons.info_outline), // The 'i' info icon
                              color: Colors.white, // Color for the icon
                              onPressed: () {
                                // Show the dialog when the info icon is tapped
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Rounded edges for AlertDialog
                                      ),
                                      title: Text(
                                        'Information',
                                        style: TextStyle(
                                            color: MyColors
                                                .white), // Custom text style for the title
                                      ),
                                      content: Text(
                                        'Your score is calculated based on the correctness of your answer! In other words; it depends on how close you are to the real answer...',
                                        style: TextStyle(
                                            color: MyColors
                                                .black), // Custom text style for the content
                                      ),
                                      backgroundColor: MyColors.green.withAlpha(
                                          250), // Background color for AlertDialog
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Close',
                                              style: TextStyle(
                                                  color: MyColors
                                                      .white)), // Custom text style for the button
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: MyColors
                                                .black, // Background color for the button
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20), // Rounded edges for button
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Responsive spacing
                    // The content of your questions goes here
                    QPageInner(
                      currentQIdx: _currentQIdx,
                      prevQuestion: _prevQuestion,
                      nextQuestion: _nextQuestion,
                      onScoreUpdated:
                          _updateScore, // Pass the update score method
                    ),
                    SizedBox(height: screenHeight * 0.01), // Responsive spacing
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




// // ignore_for_file: prefer_const_constructors

// import 'package:blurrycontainer/blurrycontainer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/home_page.dart';
// import 'package:flutter_application_1/screens/mycolors.dart';
// import 'package:flutter_application_1/screens/myfonts.dart';
// import 'package:flutter_application_1/screens/myicons.dart';
// import 'package:flutter_application_1/screens/search_page.dart';
// import 'package:flutter_application_1/services/question_page_inner.dart';
// import 'package:flutter_application_1/services/question_manager.dart';

// class QPage extends StatefulWidget {
//   final int questionNum;

//   QPage({super.key, required this.questionNum}) {
//     assert(questionNum > 0);
//   }

//   @override
//   State<QPage> createState() => _QPageState();
// }

// class _QPageState extends State<QPage> {
//   int _currentQIdx = 0;
//   List<String> choices = []; // Placeholder for choices list
//   String questionStr = ""; // Placeholder for question string

//   @override
//   void initState() {
//     super.initState();
//     // You should load your questions and choices here and set them to `choices` and `questionStr`
//   }

//   void _nextQuestion() {
//     int questionNum = widget.questionNum;
//     if (!(questionNum > 0)) return;

//     int newIndex = _currentQIdx + 1;
//     if (newIndex >= questionNum) return;

//     setState(() {
//       _currentQIdx = newIndex;
//     });
//   }

//   void _prevQuestion() {
//     int questionNum = widget.questionNum;
//     if (!(questionNum > 0)) return;

//     int newIndex = _currentQIdx - 1;
//     if (newIndex < 0) return;

//     setState(() {
//       _currentQIdx = newIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.green,
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("assets/images/Splash.png"), fit: BoxFit.cover),
//         ),
//         child: Center(
//           child: BlurryContainer(
//             borderRadius: BorderRadius.circular(35),
//             width: MediaQuery.of(context).size.width - 50,
//             height: MediaQuery.of(context).size.height - 50,
//             blur: 25,
//             color: MyColors.white.withAlpha(100),
//             child: Container(
//               padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
//               child: Column(
//                 children: [
//                   // TopBar(), // Define this widget or remove the reference
//                   SizedBox(height: 15),
//                   Row(
//                     children: [
//                       InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => HomePage()),
//                             );
//                           },
//                           child: MyIcons.backhome()),
//                       Expanded(child: Container()),
//                       InkWell(child: MyIcons.qhelparrow()),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Stack(
//                     children: [
//                       // Add your content here
//                       Positioned.fill(
//                         child: QPageInner(
//                           currentQIdx: _currentQIdx,
//                           prevQuestion: _prevQuestion,
//                           nextQuestion: _nextQuestion,
//                         ),
//                       ),
//                       // More content here
//                     ],
//                   ),
//                   // BottomNav() // Define this widget or remove the reference
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//