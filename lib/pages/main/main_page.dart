import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/pages/main/main.dart';
import 'package:food_ppopgi/pages/main/map/map_page.dart';
import 'package:food_ppopgi/pages/main/random/random_page.dart';

import '../../common/common.dart';
import 'list/list.dart';

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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RegisterButton(
            onTap: () {
              Navigator.pushNamed(context, '/request/register');
            },
            text: '요청사항 작성',
          ),
          const SizedBox(height: 60),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: defaultColor.withOpacity(0.8),
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
              color: defaultColor.withOpacity(0.6),
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
              return RestaurantListPage();
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
