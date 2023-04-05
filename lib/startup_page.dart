// ignore_for_file: prefer_const_constructors

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'mycolors.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"), fit: BoxFit.cover),
        ),
        child: BlurryContainer(
          borderRadius: BorderRadius.circular(35),
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height - 50,
          blur: 25,
          color: MyColors.white.withAlpha(100),
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: SlideAction(
              borderRadius: 35,
              elevation: 0,
              onSubmit: () {},
            ),
          ),
        ),
      ),
    );
  }
}
