// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/mycolors.dart';
import 'package:flutter_application_1/myfonts.dart';
import 'package:flutter_application_1/myicons.dart';
import 'package:flutter_application_1/search_page.dart';
import 'package:flutter_application_1/setttings_page.dart';
import 'home_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    SettingsPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.green,
        // ignore: avoid_unnecessary_containers
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: MyColors.black.withAlpha(0),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: MyIcons.home(),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: MyIcons.search(),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: MyIcons.settings(),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
