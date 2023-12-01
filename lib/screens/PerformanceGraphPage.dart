// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_application_1/screens/question_page.dart';
import 'package:flutter_application_1/screens/search_page.dart';
import 'package:flutter_application_1/services/question_manager.dart';
import 'package:flutter_application_1/services/question_page_inner.dart';

import 'home_page.dart';

class PerformanceGraphPage extends StatefulWidget {
  @override
  _PerformanceGraphPageState createState() => _PerformanceGraphPageState();
}

class _PerformanceGraphPageState extends State<PerformanceGraphPage> {
  late Map<String, double> _chapterScores;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize chapter scores
  //   _chapterScores = QuestMgr.instance.getChapterScores();
  // }

  @override
  Widget build(BuildContext context) {
    // This should be your actual data from QuestMgr
    final data = {
      'Chapter 1': 3.0,
      'Chapter 2': 5.0,
      // ... more chapters
    };

    // Convert data to a format suitable for the graphing library
    // Create the graph widget (You can replace this with your actual graph widget)

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
                    TopBarDis(),
                    Expanded(child: Container()),
                    BlurryContainer(
                      blur: 100,
                      width: screenSize.width,
                      height: screenSize.height * 0.7,
                      color: MyColors.darkBlue.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text("My Performance",
                                style: FontStyles.categories),
                            SizedBox(height: 20),
                            // Insert your graph widget here
                            // CustomBarChart(
                            //     _chapterScores), // Your interactive graph widget
                            // _buildPerformanceStatement(
                            //     _chapterScores), // Your dynamic performance statement widget
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

// Widget _buildPerformanceStatement(chapterScores) {
//   // Determine the best and worst chapters based on scores
//   String bestChapter = chapterScores.keys.first; // Dummy logic for now
//   String worstChapter = chapterScores.keys.last; // Dummy logic for now

//   return Column(
//     children: [
//       Text('You have done very well in $bestChapter'),
//       InkWell(
//         onTap: () {
//           // Navigate to PDFViewer for best chapter
//         },
//         child: Text(bestChapter,
//             style: TextStyle(decoration: TextDecoration.underline)),
//       ),
//       Text('You need to improve in $worstChapter'),
//       InkWell(
//         onTap: () {
//           // Navigate to PDFViewer for worst chapter
//         },
//         child: Text(worstChapter,
//             style: TextStyle(decoration: TextDecoration.underline)),
//       ),
//     ],
//   );
// }

// class CustomBarChart extends StatelessWidget {
//   final Map<String, double> data;

//   CustomBarChart(this.data);

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(300, 200), // Adjust the size as needed
//       painter: BarChartPainter(data),
//     );
//   }
// }

// class BarChartPainter extends CustomPainter {
//   final Map<String, double> data;

//   BarChartPainter(this.data);

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Define chart properties
//     final barWidth = 30.0;
//     final spacing = 20.0;
//     final maxValue = data.values.reduce((a, b) => a > b ? a : b);
//     final scaleFactor = size.height / maxValue;

//     // Define colors
//     final barColor = Colors.blue;

//     // Draw bars
//     double startX = 10.0;
//     data.forEach((key, value) {
//       final barHeight = value * scaleFactor;
//       final barRect =
//           Rect.fromLTWH(startX, size.height - barHeight, barWidth, barHeight);
//       canvas.drawRect(barRect, Paint()..color = barColor);
//       startX += barWidth + spacing;
//     });
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

class CircDisclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: MyColors.white.withAlpha(85),
      child: IconButton(
        icon: Icon(Icons.info_outline),
        color: MyColors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  'Disclaimer !',
                  style: TextStyle(
                    color: MyColors.white,
                  ),
                ),
                content: Text(
                  "Scores, Analytics and performance here are all powered by an AI System, Don't take these here for granted! Always refer to your instructor for more feedback on your academic performance!",
                  style: TextStyle(
                    color: MyColors.black,
                  ),
                ),
                backgroundColor: MyColors.green.withAlpha(250),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: MyColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:
                        Text('Close', style: TextStyle(color: MyColors.white)),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TopBarDis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const HomePage())),
          child: CircleAvatar(
            backgroundColor: MyColors.white.withAlpha(95),
            child: MyIcons.arrowleft(),
          ),
        ),
        Expanded(child: Container()),
        CircDisclaimer(),
      ],
    );
  }
}
