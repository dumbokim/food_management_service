import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_management_service/pages/main/list/review_list.dart';

import '../../../data/data.dart';
import 'restaurant_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple,
          centerTitle: true,
          title: const Text(
           '목록',
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
            ],
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            RestaurantListPage(),
            ReviewListPage(),
          ],
        ),
      ),
    );
  }
}
