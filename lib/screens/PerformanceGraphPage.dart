//ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, file_names, avoid_print, unused_local_variable

import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:flutter_application_1/screens/pdf_page.dart';
import 'package:flutter_application_1/screens/question_page.dart';
import 'package:flutter_application_1/screens/search_page.dart';
import 'package:flutter_application_1/services/question_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'home_page.dart';
import 'myfonts.dart';

class PerformanceGraphPage extends StatefulWidget {
  @override
  _PerformanceGraphPageState createState() => _PerformanceGraphPageState();
}

class _PerformanceGraphPageState extends State<PerformanceGraphPage> {
  late Map<String, double> _chapterScores;
  final List<String> _chapters = [
    'Fundamentals of Nutrition',
    'Nutrient Composition and Types',
    'Functional Foods and Food Composition',
    'Nutrition Science and Interdisciplinary Aspects',
    'Healthy Diet Characteristics',
    'Dietary Guidelines and Food-Based Dietary Goals',
    'Food Labeling and Nutritional Information',
    'Traffic Light Labels and Nutritional Claims',
    'Health Claims and Product Comparison',
    'Food Label Regulations and Food Additives (E Numbers)',
    'Eating Disorders',
    'Obesity',
    'Diabetes Mellitus',
    'Glycemic Index',
    'Lifestyle Advice for Diabetes Management',
  ];
  List<double> _scores = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final QuestMgr? questMgr = QuestMgr.instance();
    // Initialize the scores map if it doesn't exist
    if (questMgr!.getChapterScores().isEmpty) {
      questMgr.initializeAllChapterScores();
    }
    _chapterScores = questMgr.getChapterScores();

    // Print _chapterScores to debug
    print("Chapter Scores: $_chapterScores");

    // Use the predefined list of chapters to get the scores
    _scores =
        _chapters.map((chapter) => _chapterScores[chapter] ?? 0.0).toList();

    // Print _scores to debug
    print("Scores: $_scores");

    setState(() {}); // Refresh the page with the updated data
  }

  String get highestScoringChapter {
    if (_scores.isNotEmpty) {
      final highestScoreIndex = _scores.indexOf(_scores.reduce(max));
      return _chapters[highestScoreIndex];
    }
    return '';
  }

  String get lowestScoringChapter {
    if (_scores.isNotEmpty) {
      final lowestScoreIndex = _scores.indexOf(_scores.reduce(min));
      return _chapters[lowestScoreIndex];
    }
    return '';
  }

  Widget linkToPdfPage(String chapterName) {
    return InkWell(
      child: Text(
        chapterName,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PdfPage(filePath: chapterName),
          ),
        );
      },
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: MyColors.white, // Set your desired color here
          borderRadius:
              BorderRadius.circular(4), // Optional: to round the corners
        ),
      ],
    );
  }

  Widget _createChart() {
    _loadData();
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < _scores.length; i++) {
      Color barColor = _scores[i] > 0.5 ? Colors.green : Colors.red;
      barGroups.add(_makeGroupData(i, _scores[i], barColor));
    }

    // Print barGroups to debug
    print("Bar Groups: $barGroups");

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.grey.withAlpha(0),
      ),
      // Set the chart background to green
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text((value.toInt() + 1).toString()),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: false, // Remove the grid lines
          ),
          borderData: FlBorderData(
            show: false, // Optionally remove the border as well
          ),
          barTouchData: BarTouchData(
            enabled: false, // Disable touch interactions if you don't need them
          ),
          alignment: BarChartAlignment.spaceAround,
          maxY: _scores.isNotEmpty
              ? _scores.reduce(max) * 1.12
              : 1, // Adjust maxY based on the highest score
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.green,
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView for proper scrolling
        child: Container(
          height: screenSize.height, // Set the container height
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Splash.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: BlurryContainer(
              borderRadius: BorderRadius.circular(35),
              height: screenSize.height * 0.9,
              width: screenSize.width * 0.9,
              blur: 25,
              color: MyColors.white.withAlpha(100),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Fit the content size
                  children: [
                    TopBarDis(),
                    SizedBox(
                        height: screenSize.height *
                            0.05), // Adjust the space between the elements
                    BlurryContainer(
                      blur: 100,
                      width: screenSize.width *
                          1, // Adjust the width based on the screen size
                      height: screenSize.height *
                          0.6, // Adjust the height based on the screen size
                      color: MyColors.darkBlue.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text("My Performance",
                                style: FontStyles.categories),
                            SizedBox(height: 20),
                            Expanded(
                              child: _createChart(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    if (_scores.isNotEmpty) ...[
                      Text(
                        'Check out your best topic: ',
                        style: FontStyles.basic,
                      ),
                      linkToPdfPage(highestScoringChapter),
                      Text(
                        'Review the topic you need to improve: ',
                        style: FontStyles.basic,
                      ),
                      linkToPdfPage(lowestScoringChapter),
                    ],
                    SizedBox(height: screenSize.height * 0.01),
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
          onTap: () => Navigator.of(context).pop(),
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
