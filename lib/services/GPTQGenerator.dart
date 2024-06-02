import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_1/services/const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> generateQuestion(String prompt) async {
  final Map<String, dynamic> body = {
    "model": "gpt-4o",
    "messages": [
      {
        "role": "system",
        "content":
            "You are an assistant used to generate MCQs on a specific format within specific topics. You need to strictly follow the guidelines and generate everything correctly, sticking to the format, point for each answer depending on its closeness to the real answer, indicate the correct question, and provide a short help part to assist the student with the answer."
      },
      {"role": "user", "content": prompt}
    ],
    "max_tokens": 150,
    "n": 1,
    "stop": null,
    "temperature": 0.7,
  };

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ApiKeys.LapiKey}',
    },
    body: json.encode(body),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    String content = data['choices'][0]['message']['content'];

    // Print the raw content for debugging
    print("Raw content: $content");

    // Use regular expressions to parse the content correctly
    final questionRegex = RegExp(r'Question:\s*(.*)');
    final choicesRegex = RegExp(r'Choices:\s*([\s\S]*?)\nPoints:');
    final pointsRegex = RegExp(r'Points:\s*([\s\S]*?)\n');
    final correctRegex = RegExp(r'Correct:\s*(\d+)');
    final helpRegex = RegExp(r'Help:\s*(.*)');

    final questionMatch = questionRegex.firstMatch(content);
    final choicesMatch = choicesRegex.firstMatch(content);
    final pointsMatch = pointsRegex.firstMatch(content);
    final correctMatch = correctRegex.firstMatch(content);
    final helpMatch = helpRegex.firstMatch(content);

    if (questionMatch != null &&
        choicesMatch != null &&
        pointsMatch != null &&
        correctMatch != null &&
        helpMatch != null) {
      String question = questionMatch.group(1)!.trim();
      String help = helpMatch.group(1)!.trim();

      // Split choices by numbers followed by a period or newline
      List<String> choices = choicesMatch
          .group(1)!
          .split(RegExp(r'\d+\.\s*'))
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      // Split points by commas or new lines
      List<double> points = pointsMatch
          .group(1)!
          .split(RegExp(r'[\s,]+'))
          .map((e) => double.tryParse(e.trim()) ?? 0.0)
          .toList();

      int correct = int.tryParse(correctMatch.group(1)!.trim()) ?? 0;

      // Ensure points list matches the choices list in length
      if (points.length != choices.length) {
        print('Mismatch between choices and points length');
        throw Exception('Mismatch between choices and points length');
      }

      return {
        'question': question,
        'choices': choices,
        'points': points,
        'correct': correct,
        'help': help, // Add the help part
      };
    } else {
      print('Unexpected format: $content');
      throw Exception('Unexpected response format');
    }
  } else {
    print('Failed to generate question: ${response.body}');
    throw Exception('Failed to generate question');
  }
}

String createPrompt(int difficulty, String chapter) {
  return '''
  Generate a multiple-choice question about $chapter with the following criteria:
  - Difficulty level: $difficulty
  - Four multiple-choice answers
  - Each answer has a specific weight (0.25, 0.5, 0.75, 1)
  - Indicate the correct answer by providing the index of the correct answer (0-based index)
  - Provide a short help part to assist the student with the answer
  
  Example:
  Question: What is a primary source of Vitamin C?
  Choices: Oranges, Apples, Oranges & Strawberries, Potatoes
  Points: 1, 0.25, 0.75, 0.5
  Correct: 0
  Help: Think about common fruits that are known for their high vitamin C content.
  ''';
}

Future<String> getFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<void> generateQuestions(int numQuestions, int startDifficulty) async {
  List<Map<String, dynamic>> questions = [];
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
      questions.add(question);
      print(question); // Print each question to verify format
    } catch (e) {
      print("Error generating question: $e");
    }
  }

  // Write questions to JSON file
  String jsonString = json.encode(questions);
  // Save to file in device storage
  final path = await getFilePath();
  final file = File('$path/generated_questions.json');
  await file.writeAsString(jsonString);
}
