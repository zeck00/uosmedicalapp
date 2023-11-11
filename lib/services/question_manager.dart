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

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class QuestMgr {
  static QuestMgr? _sInstance;
  static bool _sInstanceStartCreate = false;

  static Future<QuestMgr> createSingleton() async {
    if (_sInstanceStartCreate) {
      while (_sInstance == null) {
        await Future.delayed(Duration(milliseconds: 10));
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

  Future<void> _initialize() async {
    try {
      final jsonString = await rootBundle.loadString('assets/questions.json');
      final List<dynamic> data = json.decode(jsonString);
      _questionsData = List<Map<String, dynamic>>.from(data);

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
    } catch (e) {
      print('Failed to initialize questions: $e');
      _questionNum = 0;
      _questionIndexMap = [];
      _questionAnswerIndexMap = [];
    }
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

  Future<bool> checkQuestionChoices(int index, List<int> choiceIndices) async {
    int mappedIndex = _mapQuestionIndex(index);
    int correctAnswerIndex = _questionsData[mappedIndex]['correct'];
    return choiceIndices.contains(correctAnswerIndex);
  }
}
