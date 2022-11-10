import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_management_service/pages/main/random/random_food.dart';
import 'package:food_management_service/pages/main/random/random_restaurant.dart';
import 'package:food_management_service/pages/main/random/random_type_page.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  int _currentIndex = 0;

  final _titles = [
    '음식 종류 돌림판',
    '메뉴 돌림판',
    '음식점 돌림판',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple,
          centerTitle: true,
          title: Text(
            _titles[_currentIndex],
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.purple,
            indicatorColor: Colors.purple,
            onTap: (int index) {
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
          children: const [
            RandomTypePage(),
            RandomFoodPage(),
            RandomRestaurantPage(),
          ],
        ),
      ),
    );
  }
}
