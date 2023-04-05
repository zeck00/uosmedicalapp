// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SlideAction()),
    );
  }
}
