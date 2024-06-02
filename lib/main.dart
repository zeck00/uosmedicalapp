// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/startup_page.dart';
import 'package:flutter_application_1/services/GPTQGenerator.dart';
import 'package:flutter_application_1/services/question_manager.dart';
import 'package:uosmedicalapp_client/uosmedicalapp_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await generateQuestions(
      10, 1); // Generate 10 questions starting with difficulty 1
  await QuestMgr
      .createSingleton(); // Initialize QuestMgr with the generated questions
  // Lock the device orientation to portrait up and portrait down
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Han App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: StartupPage(),
    );
  }
}
