// library question_manager;

// import 'package:flutter_application_1/main.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

// class QuestMgr {
//   static QuestMgr? _sInstance;
//   static bool _sInstanceStartCreate = false;

//   static Future<QuestMgr> createSingleton() async {
//     if (_sInstanceStartCreate) {
//       while (_sInstance == null) {}
//     } else {
//       _sInstanceStartCreate = true;

//       var instance = QuestMgr();
//       await instance._initialize();

//       _sInstance = instance;
//     }
//     return _sInstance as QuestMgr;
//   }

//   static QuestMgr? instance() => _sInstance;

//   late int _questionNum;
//   late List<int> _questionIndexMap;
//   late List<List<int>> _questionAnswerIndexMap;

//   _initializeQuestionIndexMap() async {
//     _questionIndexMap = List.generate(_questionNum, (index) => index);
//     _questionIndexMap.shuffle();
//   }

//   _initializeQuestionAnswerIndexMap() async {
//     List<List<int>?> questionAnswerIndexMap =
//         List<List<int>?>.generate(_questionNum, (index) => null);

//     for (int index = 0; index < _questionNum; index++) {
//       var list = List.generate(
//           await client.questServer.getQuestionChoiceNum(index),
//           (answerIndex) => answerIndex);
//       list.shuffle();
//       questionAnswerIndexMap[index] = list;
//     }

//     _questionAnswerIndexMap = questionAnswerIndexMap.cast<List<int>>();
//   }

//   _doUnitTesting() async {
//     int questionNum = getQuestionNum();

//     List<String?> questions = List.generate(questionNum, (index) => null);
//     Map<String, List<String>> questionChoices = {};

//     print("Questions available:");

//     if (questionNum > 0) {
//       for (int index = 0; index < questionNum; index++) {
//         String questionStr = await getQuestion(index);
//         questions[index] = questionStr;

//         List<String> choices = await getQuestionChoices(index);
//         questionChoices[questionStr] = choices;

//         print("${index + 1}. $questionStr");
//         for (String choice in choices) {
//           print("    * $choice");
//         }
//       }
//     } else {
//       print("None");
//     }

//     int getQuestionChoiceIndex(String questionStr, String choice) {
//       return questionChoices[questionStr]!.indexOf(choice);
//     }

//     validate(
//         int questionIndex, String questionStr, List<String> choices) async {
//       print(
//           "Question \"$questionStr\" should have the following correct choices:");
//       for (String choice in choices) {
//         print(
//             "    * \"$choice\", index ${getQuestionChoiceIndex(questionStr, choice)}");
//       }
//       List<int> choiceIndices = List.generate(
//           choices.length,
//           (answerIndex) =>
//               getQuestionChoiceIndex(questionStr, choices[answerIndex]));
//       bool correct = await checkQuestionChoices(questionIndex, choiceIndices);
//       if (correct) {
//         print("Well, they are correct!");
//       } else {
//         print("They are incorrect! Please panic and run around in circles!!");
//       }
//     }

//     // Correct choices
//     print("Testing correct choices...");
//     for (int index = 0; index < questionNum; index++) {
//       String questionStr = questions[index]!;
//       late List<String> choices;
//       if (questionStr == "What is 1 + 1?") {
//         choices = ["2"];
//       } else if (questionStr == "Who developed this application?") {
//         choices = ["Abood", "Zack00"];
//       } else if (questionStr == "Please choose \"Choice 4\".") {
//         choices = ["Choice 4"];
//       } else {
//         choices = [];
//       }
//       await validate(index, questionStr, choices);
//     }

//     // Partially correct choices
//     print("Testing partially correct choices...");
//     for (int index = 0; index < questionNum; index++) {
//       String questionStr = questions[index]!;
//       late List<String> choices;
//       if (questionStr == "What is 1 + 1?") {
//         choices = ["2", "3"];
//       } else if (questionStr == "Who developed this application?") {
//         choices = ["Abood"];
//       } else if (questionStr == "Please choose \"Choice 4\".") {
//         choices = [];
//       } else {
//         choices = [];
//       }
//       await validate(index, questionStr, choices);
//     }

//     // Incorrect choices
//     print("Testing incorrect choices...");
//     for (int index = 0; index < questionNum; index++) {
//       String questionStr = questions[index]!;
//       late List<String> choices;
//       if (questionStr == "What is 1 + 1?") {
//         choices = ["3", "4"];
//       } else if (questionStr == "Who developed this application?") {
//         choices = ["My neighbour"];
//       } else if (questionStr == "Please choose \"Choice 4\".") {
//         choices = ["Choice 2"];
//       } else {
//         choices = [];
//       }
//       await validate(index, questionStr, choices);
//     }
//   }

//   _initialize() async {
//     try {
//       _questionNum = await client.questServer.getQuestionNum();
//     } catch (e) {
//       print('$e');
//       _questionNum = 0;
//     }

//     await _initializeQuestionIndexMap();
//     await _initializeQuestionAnswerIndexMap();

//     // await _doUnitTesting();
//   }

//   int getQuestionNum() {
//     return _questionNum;
//   }

//   int _mapQuestionIndex(int index) {
//     assert(0 <= index && index < _questionNum);
//     return _questionIndexMap[index];
//   }

//   int _mapQuestionAnswerIndex(int index, int answerIndex) {
//     assert(0 <= index && index < _questionNum);
//     List<int> answerIndexMap = _questionAnswerIndexMap[index];
//     assert(0 <= index && index < answerIndexMap.length);
//     return answerIndexMap[answerIndex];
//   }

//   Future<String> getQuestion(int index) async {
//     return client.questServer.getQuestion(_mapQuestionIndex(index));
//   }

//   Future<int> getQuestionChoiceNum(int index) async {
//     return client.questServer.getQuestionChoiceNum(_mapQuestionIndex(index));
//   }

//   Future<List<String>> getQuestionChoices(int index) async {
//     List<String> questionChoices =
//         await client.questServer.getQuestionChoices(_mapQuestionIndex(index));

//     return List.generate(
//         questionChoices.length,
//         (answerIndex) =>
//             questionChoices[_mapQuestionAnswerIndex(index, answerIndex)]);
//   }

//   Future<bool> checkQuestionChoices(int index, List<int> choiceIndices) async {
//     List<int> mappedChoiceIndices = List.generate(
//         choiceIndices.length,
//         (choiceIndex) =>
//             _mapQuestionAnswerIndex(index, choiceIndices[choiceIndex]));
//     return client.questServer.checkQuestionChoices(index, mappedChoiceIndices);
//   }
// }

//FROM SERVER ^^^^^^^^^^^^^^^^^^

//FROM JSON

// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print

//static from json
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

// class QuestMgr {
//   double _totalScore = 0; // Add a property to track the total score
//   static QuestMgr? _sInstance;
//   static bool _sInstanceStartCreate = false;

//   static Future<QuestMgr> createSingleton() async {
//     if (_sInstanceStartCreate) {
//       while (_sInstance == null) {
//         await Future.delayed(Duration(milliseconds: 5));
//       }
//     } else {
//       _sInstanceStartCreate = true;
//       var instance = QuestMgr();
//       await instance._initialize();
//       _sInstance = instance;
//       _sInstanceStartCreate = false;
//     }
//     return _sInstance!;
//   }

//   static QuestMgr? instance() => _sInstance;

//   late int _questionNum;
//   late List<int> _questionIndexMap;
//   late List<List<int>> _questionAnswerIndexMap;
//   late List<Map<String, dynamic>>
//       _questionsData; // Holds the full questions data

//   double getScore() {
//     return _totalScore;
//   }

//   Map<int, bool> _answeredQuestions = {};
//   // This map keeps track of the currently selected answer's points for each question.
//   // This map keeps track of the previously selected answer's index for each question.
//   Map<int, int> _selectedAnswers = {};

//   // Call this method when the user selects an answer.
//   void selectAnswer(int questionIndex, int choiceIndex) {
//     var questionData = _questionsData[_mapQuestionIndex(questionIndex)];
//     var chapter = questionData['chapter'];
//     var pointsArray = questionData['points'] as List;
//     // If an answer was previously selected for this question, subtract its points.
//     if (_selectedAnswers.containsKey(questionIndex)) {
//       int previousChoiceIndex = _selectedAnswers[questionIndex]!;
//       double previousPoints =
//           (pointsArray[previousChoiceIndex] as num).toDouble();

//       // Subtract previous points from total and chapter score
//       _totalScore -= previousPoints;
//       updateScore(chapter, -previousPoints); // Subtracting from chapter score
//     }

//     // Add points for the newly selected answer.
//     double selectedPoints = (pointsArray[choiceIndex] as num).toDouble();

//     // Add new points to total and chapter score
//     _totalScore += selectedPoints;
//     updateScore(chapter, selectedPoints); // Adding to chapter score

//     // Update the map with the new choice's index.
//     _selectedAnswers[questionIndex] = choiceIndex;
//   }

//   void resetScoreForQuestion(int index, int choiceIndex) {
//     // Retrieve the points list for the specific question
//     List<dynamic> pointsList =
//         _questionsData[_mapQuestionIndex(index)]['points'];
//     // Get the points for the choice index
//     double points = (pointsList[choiceIndex] as num).toDouble();

//     // Subtract the points for the previously selected answer
//     if (_totalScore == 0) {
//       _totalScore = 0;
//     } else {
//       _totalScore += points;
//     }
//     // Mark the question as unanswered
//     _answeredQuestions[index] = false;
//   }

//   Map<String, double> _chapterScores = {};
//   final List<String> _allChapters = [
//     'Fundamentals of Nutrition',
//     'Nutrient Composition and Types',
//     'Functional Foods and Food Composition',
//     'Nutrition Science and Interdisciplinary Aspects',
//     'Healthy Diet Characteristics',
//     'Dietary Guidelines and Food-Based Dietary Goals',
//     'Food Labeling and Nutritional Information',
//     'Traffic Light Labels and Nutritional Claims',
//     'Health Claims and Product Comparison',
//     'Food Label Regulations and Food Additives (E Numbers)',
//     'Eating Disorders',
//     'Obesity',
//     'Diabetes Mellitus',
//     'Glycemic Index',
//     'Lifestyle Advice for Diabetes Management',
//   ];
//   // Call this method at the start of the quiz or when resetting the quiz
//   void initializeAllChapterScores() {
//     Map<String, double> currentScores = getChapterScores();

//     if (currentScores.isEmpty) {
//       // Initialize scores only if they haven't been already
//       for (var chapter in _allChapters) {
//         _chapterScores[chapter] = 0.0;
//       }
//     }
//   }

//   List<String> getChapters() {
//     // Using a Set to ensure uniqueness
//     var chaptersSet = <String>{};
//     for (var questionData in _questionsData) {
//       chaptersSet.add(questionData['chapter']);
//     }
//     // Return the chapters as a list
//     return chaptersSet.toList();
//   }

//   // Call this method to update the score for a chapter
//   void updateScore(String chapter, double scoreChange) {
//     // Check if the chapter is already in the map
//     if (_chapterScores.containsKey(chapter)) {
//       // Update the existing score
//       _chapterScores[chapter] = (_chapterScores[chapter] ?? 0.0) + scoreChange;
//     } else {
//       // Initialize the score for the chapter
//       _chapterScores[chapter] = scoreChange;
//     }
//   }

//   // Call this method to reset the scores
//   void resetScores() {
//     for (var key in _chapterScores.keys) {
//       _chapterScores[key] = 0.0;
//     }
//   }

//   Map<String, double> getChapterScores() {
//     return _chapterScores;
//   }

//   Future<void> _initialize() async {
//     try {
//       final jsonString = await rootBundle.loadString('assets/questions.json');
//       final List<dynamic> data = json.decode(jsonString);
//       _questionsData = List<Map<String, dynamic>>.from(data);

//       _questionNum = _questionsData.length;
//       _questionIndexMap = List.generate(_questionNum, (index) => index);
//       _questionIndexMap.shuffle();

//       _questionAnswerIndexMap = _questionsData.map<List<int>>(
//         (question) {
//           List<dynamic> choices = question['choices'];
//           return List<int>.generate(choices.length, (index) => index);
//         },
//       ).toList();

//       for (var answerIndexMap in _questionAnswerIndexMap) {
//         answerIndexMap.shuffle();
//       }
//     } catch (e) {
//       print('Failed to initialize questions: $e');
//       _questionNum = 0;
//       _questionIndexMap = [];
//       _questionAnswerIndexMap = [];
//     }
//   }

//   int getQuestionNum() {
//     return _questionNum;
//   }

//   int _mapQuestionIndex(int index) {
//     assert(index >= 0 && index < _questionNum, 'index out of bounds');
//     return _questionIndexMap[index];
//   }

//   Future<String> getQuestion(int index) async {
//     int mappedIndex = _mapQuestionIndex(index);
//     return _questionsData[mappedIndex]['question'];
//   }

//   Future<int> getQuestionChoiceNum(int index) async {
//     int mappedIndex = _mapQuestionIndex(index);
//     List<dynamic> choices = _questionsData[mappedIndex]['choices'];
//     return choices.length;
//   }

//   Future<List<String>> getQuestionChoices(int index) async {
//     int mappedIndex = _mapQuestionIndex(index);
//     List<dynamic> choices = _questionsData[mappedIndex]['choices'];
//     return List<String>.from(choices);
//   }

//   Future<int> getCorrectAnswerIndex(int index) async {
//     int mappedIndex = _mapQuestionIndex(index);
//     return _questionsData[mappedIndex]['correct'];
//   }

//   Future<bool> checkQuestionChoices(int index, List<int> choiceIndices) async {
//     int mappedIndex = _mapQuestionIndex(index);
//     int correctAnswerIndex = _questionsData[mappedIndex]['correct'];
//     return choiceIndices.contains(correctAnswerIndex);
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'gptqgenerator.dart'; // Make sure this import is correct

class QuestMgr {
  double _totalScore = 0; // Add a property to track the total score
  static QuestMgr? _sInstance;
  static bool _sInstanceStartCreate = false;

  static Future<QuestMgr> createSingleton() async {
    if (_sInstanceStartCreate) {
      while (_sInstance == null) {
        await Future.delayed(Duration(milliseconds: 5));
      }
    } else {
      _sInstanceStartCreate = true;
      var instance = QuestMgr();
      await instance._initialize();
      _sInstance = instance;
      _sInstanceStartCreate = false;
    }
    return _sInstance!;
  }

  static QuestMgr? instance() => _sInstance;

  late int _questionNum;
  late List<int> _questionIndexMap;
  late List<List<int>> _questionAnswerIndexMap;
  late List<Map<String, dynamic>>
      _questionsData; // Holds the full questions data

  double getScore() {
    return _totalScore;
  }

  Map<int, bool> _answeredQuestions = {};
  Map<int, int> _selectedAnswers = {};

  void selectAnswer(int questionIndex, int choiceIndex) {
    print(
        'Selecting answer for questionIndex: $questionIndex, choiceIndex: $choiceIndex');

    int mappedIndex = _mapQuestionIndex(questionIndex);
    var questionData = _questionsData[mappedIndex];
    var pointsArray = questionData['points'] as List;
    var chapter = questionData['chapter'];

    print('Question Data: $questionData');
    print('Points Array: $pointsArray');

    if (chapter == null) {
      throw Exception("Chapter is null for question: $questionData");
    }

    if (_selectedAnswers.containsKey(questionIndex)) {
      int previousChoiceIndex = _selectedAnswers[questionIndex]!;
      double previousPoints =
          (pointsArray[previousChoiceIndex] as num).toDouble();
      _totalScore -= previousPoints;
      _updateChapterScore(chapter, -previousPoints);
      print(
          'Previous choice index: $previousChoiceIndex, Previous points: $previousPoints');
    }

    double selectedPoints = (pointsArray[choiceIndex] as num).toDouble();
    _totalScore += selectedPoints;
    _updateChapterScore(chapter, selectedPoints);
    print('Selected points: $selectedPoints, Total score: $_totalScore');

    _selectedAnswers[questionIndex] = choiceIndex;
  }

  void _updateChapterScore(String chapter, double scoreChange) {
    if (_chapterScores.containsKey(chapter)) {
      _chapterScores[chapter] = (_chapterScores[chapter] ?? 0.0) + scoreChange;
    } else {
      _chapterScores[chapter] = scoreChange;
    }
  }

  void resetScoreForQuestion(int index, int choiceIndex) {
    List<dynamic> pointsList =
        _questionsData[_mapQuestionIndex(index)]['points'];
    double points = (pointsList[choiceIndex] as num).toDouble();

    if (_totalScore == 0) {
      _totalScore = 0;
    } else {
      _totalScore += points;
    }
    _answeredQuestions[index] = false;
  }

  Map<String, double> _chapterScores = {};
  final List<String> _allChapters = [
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

  void initializeAllChapterScores() {
    if (_chapterScores.isEmpty) {
      for (var chapter in _allChapters) {
        _chapterScores[chapter] = 0.0;
      }
    }
  }

  List<String> getChapters() {
    var chaptersSet = <String>{};
    for (var questionData in _questionsData) {
      chaptersSet.add(questionData['chapter']);
    }
    return chaptersSet.toList();
  }

  void updateScore(String chapter, double scoreChange) {
    if (_chapterScores.containsKey(chapter)) {
      _chapterScores[chapter] = (_chapterScores[chapter] ?? 0.0) + scoreChange;
    } else {
      _chapterScores[chapter] = scoreChange;
    }
  }

  void resetScores() {
    for (var key in _chapterScores.keys) {
      _chapterScores[key] = 0.0;
    }
  }

  Map<String, double> getChapterScores() {
    return _chapterScores;
  }

  Future<void> _initialize() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/generated_questions.json');
      final jsonString = await file.readAsString();
      if (jsonString.isEmpty) throw Exception("JSON file is empty");

      final List<dynamic> data = json.decode(jsonString);
      _questionsData = List<Map<String, dynamic>>.from(data);

      for (var question in _questionsData) {
        if (!question.containsKey('chapter') || question['chapter'] == null) {
          throw Exception("Question is missing chapter: $question");
        }
      }

      _questionNum = _questionsData.length;
      _questionIndexMap = List.generate(_questionNum, (index) => index);
      _questionIndexMap.shuffle();

      for (var question in _questionsData) {
        List<String> choices = List<String>.from(question['choices']);
        List<double> points = List<double>.from(question['points']);
        int correctIndex = question['correct'];

        List<Map<String, dynamic>> combinedList =
            List.generate(choices.length, (index) {
          return {
            'choice': choices[index],
            'point': points[index],
            'isCorrect': index == correctIndex
          };
        });

        combinedList.shuffle();

        question['choices'] =
            combinedList.map((item) => item['choice'] as String).toList();
        question['points'] =
            combinedList.map((item) => item['point'] as double).toList();
        question['correct'] =
            combinedList.indexWhere((item) => item['isCorrect']);
      }

      _questionAnswerIndexMap = _questionsData.map<List<int>>(
        (question) {
          List<dynamic> choices = question['choices'];
          return List<int>.generate(choices.length, (index) => index);
        },
      ).toList();
    } catch (e) {
      print('Failed to initialize questions: $e');
      _questionNum = 0;
      _questionIndexMap = [];
      _questionAnswerIndexMap = [];
    }
  }

  Future<void> appendQuestions(int numQuestions, int startDifficulty) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/generated_questions.json');

    List<Map<String, dynamic>> newQuestions = [];
    List<String> chapters = [
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
      'Lifestyle Advice for Diabetes Management'
    ];

    for (int i = 0; i < numQuestions; i++) {
      int difficulty = startDifficulty + i; // Progressive difficulty
      String chapter = chapters[i % chapters.length]; // Cycle through chapters
      String prompt = createPrompt(difficulty, chapter);
      try {
        Map<String, dynamic> question = await generateQuestion(prompt);
        question['chapter'] = chapter; // Add the chapter to the question
        newQuestions.add(question);
        print(question); // Print each question to verify format
      } catch (e) {
        print("Error generating question: $e");
      }
    }

    _questionsData.addAll(newQuestions);

    _questionNum = _questionsData.length;
    _questionIndexMap = List.generate(_questionNum, (index) => index);
    _questionIndexMap.shuffle();

    _questionAnswerIndexMap = _questionsData.map<List<int>>(
      (question) {
        List<dynamic> choices = question['choices'];
        return List<int>.generate(choices.length, (index) => index);
      },
    ).toList();

    for (var answerIndexMap in _questionAnswerIndexMap) {
      answerIndexMap.shuffle();
    }

    String jsonString = json.encode(_questionsData);
    await file.writeAsString(jsonString);
  }

  void resetAllScores() {
    _totalScore = 0;
    _selectedAnswers.clear();
    resetScores(); // This resets the chapter scores
  }

  int getQuestionNum() {
    return _questionNum;
  }

  int _mapQuestionIndex(int index) {
    assert(index >= 0 && index < _questionNum, 'index out of bounds');
    return _questionIndexMap[index];
  }

  Future<String> getQuestion(int index) async {
    int mappedIndex = _mapQuestionIndex(index);
    return _questionsData[mappedIndex]['question'];
  }

  Future<int> getQuestionChoiceNum(int index) async {
    int mappedIndex = _mapQuestionIndex(index);
    List<dynamic> choices = _questionsData[mappedIndex]['choices'];
    return choices.length;
  }

  Future<List<String>> getQuestionChoices(int index) async {
    int mappedIndex = _mapQuestionIndex(index);
    List<dynamic> choices = _questionsData[mappedIndex]['choices'];
    return List<String>.from(choices);
  }

  Future<int> getCorrectAnswerIndex(int index) async {
    int mappedIndex = _mapQuestionIndex(index);
    return _questionsData[mappedIndex]['correct'];
  }

  Future<String> getQuestionHelp(int index) async {
    int mappedIndex = _mapQuestionIndex(index);
    return _questionsData[mappedIndex]['help'];
  }

  Future<bool> checkQuestionChoices(int index, List<int> choiceIndices) async {
    int mappedIndex = _mapQuestionIndex(index);
    int correctAnswerIndex = _questionsData[mappedIndex]['correct'];
    return choiceIndices.contains(correctAnswerIndex);
  }
}
