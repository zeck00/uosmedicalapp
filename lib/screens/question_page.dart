// ignore_for_file: prefer_const_constructors

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:flutter_application_1/screens/search_page.dart';
import 'package:flutter_application_1/screens/setttings_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    ),
                    Expanded(child: Container()),
                    Stack(
                      children: [
                        Positioned(
                          child: BlurryContainer(
                            width: MediaQuery.of(context).size.width,
                            height: 595,
                            borderRadius: BorderRadius.circular(35),
                            color: MyColors.blue,
                            child: Column(
                              children: [
                                SizedBox(height: 125),
                                BlurryContainer(
                                  borderRadius: BorderRadius.circular(35),
                                  width: 295,
                                  height: 95,
                                  color: MyColors.yellow.withOpacity(0.45),
                                  padding: EdgeInsets.all(15),
                                  child: Center(
                                    child: Text(
                                      "What is the definition of health according to the WHO?",
                                      style: FontStyles.questions,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                BlurryContainer(
                                  width: 295,
                                  height: 95,
                                  borderRadius: BorderRadius.circular(35),
                                  color: MyColors.darkBlue.withOpacity(0.45),
                                  child: Center(
                                    child: Text(
                                      "Health is a state of incomplete physical, well-being and merely the absence of disease or infirmity",
                                      style: FontStyles.subs,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                BlurryContainer(
                                  width: 295,
                                  height: 95,
                                  borderRadius: BorderRadius.circular(35),
                                  color: MyColors.darkBlue.withOpacity(0.45),
                                  child: Center(
                                    child: Text(
                                      "Health is a state of incomplete physical, well-being and merely the absence of disease or infirmity",
                                      style: FontStyles.subs,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                BlurryContainer(
                                  width: 295,
                                  height: 95,
                                  borderRadius: BorderRadius.circular(35),
                                  color: MyColors.darkBlue.withOpacity(0.45),
                                  child: Center(
                                    child: Text(
                                      "Health is a state of complete physical, mental and social well-being and not merely the absence of disease or infirmity",
                                      style: FontStyles.subs,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          child: BlurryContainer(
                            elevation: 10,
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            borderRadius: BorderRadius.circular(35),
                            color: MyColors.blue.withOpacity(0.45),
                            blur: 100,
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Row(
                                  children: const [
                                    SizedBox(width: 25),
                                    Text(
                                      "Let's Test Your",
                                      style: FontStyles.bigtitle,
                                    ),
                                    SizedBox(width: 30),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    SizedBox(width: 45),
                                    Text(
                                      "Knowledge !",
                                      style: FontStyles.bigtitle,
                                    ),
                                    SizedBox(width: 45),
                                  ],
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: MyColors.black.withAlpha(0),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      items: [
                        BottomNavigationBarItem(
                          icon: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            child: MyIcons.home(),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage()),
                                );
                              },
                              child: MyIcons.search()),
                          label: 'Search',
                        ),
                        BottomNavigationBarItem(
                          icon: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingsPage()),
                                );
                              },
                              child: MyIcons.settingslc()),
                          label: 'Settings',
                        ),
                      ],
                    ),
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
