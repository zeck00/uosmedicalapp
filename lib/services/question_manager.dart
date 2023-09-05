library question_manager;

import 'dart:convert';

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

  static QuestMgr? instance() {
    return _sInstance;
  }

  late List<Map> _questions;
  late List<int> _questionIndexMap;
  late List<List<int>> _questionAnswerIndexMap;

  get questionNum => _questions.length;

  _initialize() async {
    final String response =
        await rootBundle.loadString('assets/data/questions.json');
    // print(response);
    final List<Map> data =
        (await json.decode(response) as List).map((e) => e as Map).toList();
    // print("data.toString()");
    // print(data);

    // print("Wait start");
    // await Future.delayed(const Duration(seconds: 5));
    // print("Wait done");

    _questions = data;

    _questionIndexMap = List.generate(questionNum, (index) => index);
    _questionIndexMap.shuffle();

    _questionAnswerIndexMap = List.generate(
        questionNum,
        (index) => List.generate(
            (_questions[_questionIndexMap[index]]["choices"] as List).length,
            (answerIndex) => answerIndex));

    for (var list in _questionAnswerIndexMap) {
      list.shuffle();
    }
  }

  _getQuestion(int index) {
    assert(0 <= index && index < questionNum);
    return _questions[_questionIndexMap[index]];
  }

  String getQuestion(int index) {
    return _getQuestion(index)["question"];
  }

  List<String> getQuestionChoices(int index) {
    List<String> questionChoices =
        List<String>.from(_getQuestion(index)["choices"]);

    return List.generate(
        questionChoices.length,
        (answerIndex) =>
            questionChoices[_questionAnswerIndexMap[index][answerIndex]]);
  }

  bool checkQuestionChoices(int index, List<int> choiceIndices) {
    var correctAnswerIndex = _getQuestion(index)["answer_index"];
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
