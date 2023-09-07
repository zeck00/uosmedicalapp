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
    assert(0 <= index && index < await _questionNum);
    return (await _questions)[_questionIndexMap[index]];
  }

  Future<int> _getQuestionChoiceNum(int index) async =>
      ((await _getQuestion(index))["choices"] as List).length;

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

  _initialize() async {
    await _initializeQuestionIndexMap();
    await _initializeQuestionAnswerIndexMap();
  }

  Future<int> getQuestionNum() async => _questionNum;

  Future<String> getQuestion(int index) async =>
      (await _getQuestion(index))["question"];

  Future<int> getQuestionChoiceNum(int index) async =>
      _getQuestionChoiceNum(index);

  Future<List<String>> getQuestionChoices(int index) async {
    List<String> questionChoices =
        List<String>.from((await _getQuestion(index))["choices"]);

    return List.generate(
        questionChoices.length,
        (answerIndex) =>
            questionChoices[_questionAnswerIndexMap[index][answerIndex]]);
  }

  Future<bool> checkQuestionChoices(int index, List<int> choiceIndices) async {
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
