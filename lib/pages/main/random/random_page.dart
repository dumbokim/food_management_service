import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/common/common.dart';
import 'package:food_ppopgi/pages/main/main.dart';
import 'package:food_ppopgi/pages/main/random/random_food.dart';
import 'package:food_ppopgi/pages/main/random/random_restaurant.dart';
import 'package:food_ppopgi/pages/main/random/random_type_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RandomPage extends ConsumerStatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends ConsumerState<RandomPage> {
  int _currentIndex = 0;

  final _titles = [
    '음식점 돌림판',
    '음식 종류 돌림판',
    '음식 돌림판',
  ];

  final _pageLoaded = {
    0: true,
    1: false,
    2: false,
  };

  final _pages = <Widget>[
    RandomRestaurantPage(),
    SizedBox(),
    SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: defaultColor,
          centerTitle: true,
          title: Text(
            _titles[_currentIndex],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(7),
              child: RegisterSmButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/adoption/list');
                  },
                  text: '채택'),
            ),
          ],
          bottom: TabBar(
            labelColor: defaultColor,
            indicatorColor: defaultColor,
            onTap: (int index) {
              if (_pageLoaded[1] == true && _pageLoaded[2] == true) {
                setState(() => _currentIndex = index);
                return;
              }

              if (index == 1 && _pageLoaded[1] == false) {
                setState(() {
                  _pages[1] = const RandomTypePage();
                  _pageLoaded.update(1, (value) => true);
                });
              } else if (index == 2 && _pageLoaded[2] == false) {
                setState(() {
                  _pages[2] = const RandomFoodPage();
                  _pageLoaded.update(2, (value) => true);
                });
              }

              setState(() => _currentIndex = index);
            },
            tabs: const [
              Tab(icon: Icon(Icons.fork_left)),
              Tab(icon: Icon(CupertinoIcons.leaf_arrow_circlepath)),
              Tab(icon: Icon(CupertinoIcons.house_fill)),
            ],
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
    );
  }
}
