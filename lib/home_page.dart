// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/mycolors.dart';
import 'package:flutter_application_1/myfonts.dart';
import 'package:flutter_application_1/myicons.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_application_1/profile_page.dart';
import 'search_page.dart';
import 'setttings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.green,
      // ignore: avoid_unnecessary_containers
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"), fit: BoxFit.cover),
        ),
        child: Center(
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
                  BlurryContainer(
                    blur: 100,
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    color: MyColors.darkBlue.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Continue",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Where You",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Left...",
                                    style: FontStyles.categories,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              MyIcons.arrowcircle()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  BlurryContainer(
                    blur: 100,
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    color: MyColors.darkBlue.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 7, right: 10, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Explore the",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Course Material",
                                    style: FontStyles.categories,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              MyIcons.arrowcircle()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  BlurryContainer(
                    blur: 100,
                    width: MediaQuery.of(context).size.width,
                    height: 375,
                    color: MyColors.darkBlue.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 7, right: 10, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Test Your",
                                    style: FontStyles.categories,
                                  ),
                                  Text(
                                    "Knowledge",
                                    style: FontStyles.categories,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              MyIcons.arrowcircle()
                            ],
                          ),
                          SizedBox(height: 15),
                          BlurryContainer(
                            blur: 100,
                            width: MediaQuery.of(context).size.width,
                            height: 175,
                            color: MyColors.yellow.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(35),
                            elevation: 10,
                            child: Center(
                              child: Text(
                                "Health is a state of complete physical, mental and social well-being and not merely the absence of disease or infirmity",
                                style: FontStyles.questions,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Add your onPressed action here
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            35) // Set rounded corner radius
                                        ),
                                    backgroundColor: MyColors.green,
                                    minimumSize: Size(120, 45)),
                                child: Text(
                                  'True',
                                  style: FontStyles
                                      .button, // Set text color to white
                                ),
                              ),
                              SizedBox(width: 29),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your onPressed action here
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            35) // Set rounded corner radius
                                        ),
                                    backgroundColor: MyColors.pink,
                                    minimumSize: Size(120, 45)),
                                child: Text(
                                  'False',
                                  style: FontStyles
                                      .button, // Set text color to white
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                          child: MyIcons.homeslc(),
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
                            child: MyIcons.settings()),
                        label: 'Settings',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
