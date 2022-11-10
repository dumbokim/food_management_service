import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_management_service/pages/main/map/map_page.dart';
import 'package:food_management_service/pages/main/random/random_page.dart';

import 'list/list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.purple.withOpacity(0.8),
            activeColor: Colors.white,
            inactiveColor: Colors.white70,
            height: 60,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            border: Border(
                top: BorderSide(
              color: CupertinoColors.systemPurple.withOpacity(0.6),
              width: 3,
            )),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.arrow_2_circlepath_circle),
                label: '돌림판',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list_fill),
                label: '목록',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.map),
                label: '지도',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return RandomPage();
            } else if (index == 1) {
              return ListPage();
            } else if (index == 2) {
              return MapPage();
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
