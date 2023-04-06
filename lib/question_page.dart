// ignore_for_file: prefer_const_constructors

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/mycolors.dart';
import 'package:flutter_application_1/myfonts.dart';
import 'package:flutter_application_1/myicons.dart';

import 'profile_page.dart';

class QPage extends StatefulWidget {
  const QPage({super.key});

  @override
  State<QPage> createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.green,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: BlurryContainer(
            child: BlurryContainer(
              borderRadius: BorderRadius.circular(35),
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height - 50,
              blur: 25,
              color: MyColors.white.withAlpha(100),
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyIcons.hs(),
                        Expanded(child: Container()),
                        InkWell(
                          child: MyIcons.ppicon(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            child: MyIcons.backhome()),
                        Expanded(child: Container()),
                        InkWell(child: MyIcons.qhelparrow()),
                      ],
                    )
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
