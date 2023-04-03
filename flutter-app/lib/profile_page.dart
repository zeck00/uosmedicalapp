// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/mycolors.dart';
import 'package:flutter_application_1/myfonts.dart';
import 'package:flutter_application_1/myicons.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'search_page.dart';
import 'setttings_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: MyIcons.arrowleft(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()),
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        "Account Settings",
                        style: FontStyles.pagetitle,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                  BlurryContainer(
                    blur: 100,
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: MyColors.yellow.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Your Email",
                                style: FontStyles.settings,
                              ),
                              SizedBox(width: 5),
                              Text("|", style: FontStyles.bigtitle),
                              SizedBox(width: 5),
                              Text(
                                "U22106802@sharjah.ac.ae",
                                style: FontStyles.details,
                              )
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
                    height: 60,
                    color: MyColors.yellow.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "2nd Email",
                                style: FontStyles.settings,
                              ),
                              SizedBox(width: 8),
                              Text("|", style: FontStyles.bigtitle),
                              SizedBox(width: 5),
                              Text(
                                "ZZZZZZZZZ@sharjah.ac.ae",
                                style: FontStyles.details,
                              )
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
                    height: 60,
                    color: MyColors.yellow.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(35),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "2FA Method",
                                style: FontStyles.settings,
                              ),
                              SizedBox(width: 5),
                              Text("|", style: FontStyles.bigtitle),
                              SizedBox(width: 120),
                              Text(
                                "Enabled",
                                style: FontStyles.details,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Divider(
                    color: Colors.black,
                    thickness: 3,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            minimumSize: Size(120, 45)),
                        child: Text(
                          'Contact Help',
                          style: FontStyles.details, // Set text color to white
                        ),
                      ),
                      SizedBox(width: 14),
                      Text("OR"),
                      SizedBox(width: 14),
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
                            minimumSize: Size(120, 45)),
                        child: Text(
                          'Website',
                          style: FontStyles.details, // Set text color to white
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "All Copyrights reserved @ University Of Sharjah - 2023",
                    style: FontStyles.header,
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
