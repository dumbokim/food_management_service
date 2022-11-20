import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    '음식 종류 돌림판',
    '메뉴 돌림판',
    '음식점 돌림판',
  ];

  final _pageLoaded = {
    0: true,
    1: false,
    2: false,
  };

  final _pages = <Widget>[
    RandomTypePage(),
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
          foregroundColor: Colors.purple,
          centerTitle: true,
          title: Text(
            _titles[_currentIndex],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/adoption/list');
                },
                icon: Text('채택')),
          ],
          bottom: TabBar(
            labelColor: Colors.purple,
            indicatorColor: Colors.purple,
            onTap: (int index) {
              if (_pageLoaded[1] == true && _pageLoaded[2] == true) {
                setState(() => _currentIndex = index);
                return;
              }

              if (index == 1 && _pageLoaded[1] == false) {
                setState(() {
                  _pages[1] = RandomFoodPage();
                  _pageLoaded.update(1, (value) => true);
                });
              } else if (index == 2 && _pageLoaded[2] == false) {
                setState(() {
                  _pages[2] = RandomRestaurantPage();
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
