library question_manager;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:collection/collection.dart';

class QuestMgr {
  static QuestMgr? _sInstance;
  static bool _sInstanceStartCreate = false;

  static Future<QuestMgr> createSingleton() async {
    if (_sInstanceStartCreate) {
      while (_sInstance == null) {}
    } else {
      _sInstanceStartCreate = true;

      var instance = QuestMgr();
      await instance._initialize();

      _sInstance = instance;
    }
    return _sInstance as QuestMgr;
  }

  static QuestMgr? instance() => _sInstance;

  Future<List<Map>> get _questions async => List<Map>.from(await json
      .decode(await rootBundle.loadString('assets/data/questions.json')));

  late List<int> _questionIndexMap;
  late List<List<int>> _questionAnswerIndexMap;

  Future<int> get _questionNum async => (await _questions).length;

  _initializeQuestionIndexMap() async {
    _questionIndexMap = List.generate(await _questionNum, (index) => index);
    _questionIndexMap.shuffle();
  }

  Future<Map> _getQuestion(int index) async {
    List<Map> questions = await _questions;
    assert(0 <= index && index < questions.length);
    return questions[_questionIndexMap[index]];
  }

  Future<List> _getQuestionChoices(int index) async =>
      (await _getQuestion(index))["choices"] as List;

  Future<int> _getQuestionChoiceNum(int index) async =>
      (await _getQuestionChoices(index)).length;

  _initializeQuestionAnswerIndexMap() async {
    int questionNum = await _questionNum;

    List<List<int>?> questionAnswerIndexMap =
        List<List<int>?>.generate(questionNum, (index) => null);

    for (int index = 0; index < questionNum; index++) {
      var list = List.generate(
          await _getQuestionChoiceNum(index), (answerIndex) => answerIndex);
      list.shuffle();
      questionAnswerIndexMap[index] = list;
    }

    _questionAnswerIndexMap = questionAnswerIndexMap.cast<List<int>>();
  }

  _doUnitTesting() async {
    int questionNum = await getQuestionNum();

    List<String?> questions = List.generate(questionNum, (index) => null);
    Map<String, List<String>> questionChoices = {};

    print("Questions available:");

    if (questionNum > 0) {
      for (int index = 0; index < questionNum; index++) {
        String questionStr = await getQuestion(index);
        questions[index] = questionStr;

        List<String> choices = await getQuestionChoices(index);
        questionChoices[questionStr] = choices;

        print("${index + 1}. $questionStr");
        for (String choice in choices) {
          print("    * $choice");
        }
      }
    } else {
      print("None");
    }

    int getQuestionChoiceIndex(String questionStr, String choice) {
      return questionChoices[questionStr]!.indexOf(choice);
    }

    validate(
        int questionIndex, String questionStr, List<String> choices) async {
      print(
          "Question \"$questionStr\" should have the following correct choices:");
      for (String choice in choices) {
        print(
            "    * \"$choice\", index ${getQuestionChoiceIndex(questionStr, choice)}");
      }
      List<int> choiceIndices = List.generate(
          choices.length,
          (answerIndex) =>
              getQuestionChoiceIndex(questionStr, choices[answerIndex]));
      bool correct = await checkQuestionChoices(questionIndex, choiceIndices);
      if (correct) {
        print("Well, they are correct!");
      } else {
        print("They are incorrect! Please panic and run around in circles!!");
      }
    }

    // Correct choices
    print("Testing correct choices...");
    for (int index = 0; index < questionNum; index++) {
      String questionStr = questions[index]!;
      late List<String> choices;
      if (questionStr == "What is 1 + 1?") {
        choices = ["2"];
      } else if (questionStr == "Who developed this application?") {
        choices = ["Abood", "Zack00"];
      } else if (questionStr == "Please choose \"Choice 4\".") {
        choices = ["Choice 4"];
      } else {
        choices = [];
      }
      await validate(index, questionStr, choices);
    }

    // Partially correct choices
    print("Testing partially correct choices...");
    for (int index = 0; index < questionNum; index++) {
      String questionStr = questions[index]!;
      late List<String> choices;
      if (questionStr == "What is 1 + 1?") {
        choices = ["2", "3"];
      } else if (questionStr == "Who developed this application?") {
        choices = ["Abood"];
      } else if (questionStr == "Please choose \"Choice 4\".") {
        choices = [];
      } else {
        choices = [];
      }
      await validate(index, questionStr, choices);
    }

    // Incorrect choices
    print("Testing incorrect choices...");
    for (int index = 0; index < questionNum; index++) {
      String questionStr = questions[index]!;
      late List<String> choices;
      if (questionStr == "What is 1 + 1?") {
        choices = ["3", "4"];
      } else if (questionStr == "Who developed this application?") {
        choices = ["My neighbour"];
      } else if (questionStr == "Please choose \"Choice 4\".") {
        choices = ["Choice 2"];
      } else {
        choices = [];
      }
      await validate(index, questionStr, choices);
    }
  }

  _initialize() async {
    await _initializeQuestionIndexMap();
    await _initializeQuestionAnswerIndexMap();
    // await _doUnitTesting();
  }

  final _random = Random();

  _simulateLatency() async =>
      await Future.delayed(Duration(seconds: 1 + _random.nextInt(3 - 1)));

  Future<int> getQuestionNum() async {
    await _simulateLatency();
    return _questionNum;
  }

  Future<String> getQuestion(int index) async {
    await _simulateLatency();
    return (await _getQuestion(index))["question"];
  }

  Future<int> getQuestionChoiceNum(int index) async {
    await _simulateLatency();
    return _getQuestionChoiceNum(index);
  }

  Future<List<String>> getQuestionChoices(int index) async {
    await _simulateLatency();

    List questionChoices = await _getQuestionChoices(index);

    return List.generate(
        questionChoices.length,
        (answerIndex) =>
            questionChoices[_questionAnswerIndexMap[index][answerIndex]]
                as String);
  }

  Future<bool> checkQuestionChoices(int index, List<int> choiceIndices) async {
    await _simulateLatency();

    var correctAnswerIndex = (await _getQuestion(index))["answer_index"];
    if (correctAnswerIndex is int) {
      return choiceIndices.length == 1 &&
          _questionAnswerIndexMap[index][choiceIndices[0]] ==
              correctAnswerIndex;
    } else {
      List<int> mappedChoiceIndices = List.generate(
          choiceIndices.length,
          (answerIndex) =>
              _questionAnswerIndexMap[index][choiceIndices[answerIndex]]);
      return const DeepCollectionEquality.unordered()
          .equals(mappedChoiceIndices, List<int>.from(correctAnswerIndex));
    }
  }
}
