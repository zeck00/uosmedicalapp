// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'setttings_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"), fit: BoxFit.fill),
        ),
        child: Center(
          child: BlurryContainer(
            borderRadius: BorderRadius.circular(35),
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height - 50,
            blur: 20,
            color: MyColors.white.withAlpha(90),
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                children: [
                  TopBar(),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        "Recent...",
                        style: FontStyles.pagetitle,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(width: 42),
                      ElevatedButton(
                        onPressed: () {
                          // Add your onPressed action here
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 15,
                            shadowColor: MyColors.black.withAlpha(255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    35) // Set rounded corner radius
                                ),
                            backgroundColor: MyColors.darkPurple,
                            minimumSize: Size(140, 45)),
                        child: Row(
                          children: [
                            Text(
                              'Sort By',
                              style:
                                  FontStyles.button, // Set text color to white
                            ),
                            SizedBox(width: 15),
                            MyIcons.arrowdown()
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: LessonBox(),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                  BottomNav(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LessonBox extends StatelessWidget {
  const LessonBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: 100,
      width: MediaQuery.of(context).size.width,
      height: 115,
      color: MyColors.darkBlue.withOpacity(0.45),
      borderRadius: BorderRadius.circular(35),
      elevation: 10,
      child: Row(
        children: [
          MyIcons.lessonicon(),
          SizedBox(width: 10),
          Text(
            "Lesson 01",
            style: FontStyles.categories,
          ),
          SizedBox(width: 10),
          MyIcons.arrowcircle(),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

class BottomNav extends StatefulWidget {
  BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  bool isIconSelected = false;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
                MaterialPageRoute(builder: (context) => HomePage()),
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
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: MyIcons.search()),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              setState(() {
                isIconSelected = !isIconSelected;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child: MyIcons.settings(),
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyIcons.hs(),
        Expanded(child: Container()),
        InkWell(
          child: MyIcons.ppicon(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ],
    );
  }
}
