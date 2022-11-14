import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/pages/main/random/random.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RandomRestaurantPage extends ConsumerStatefulWidget {
  const RandomRestaurantPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RandomRestaurantPageState();
  }
}

class _RandomRestaurantPageState extends ConsumerState<RandomRestaurantPage> {
  final selected = StreamController<int>.broadcast();
  bool _started = false;
  bool _rotating = false;
  final random = Random();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(foodRepository);

    final restaurantList = repository.getRestaurantList;

    return CupertinoTabView(
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _started
                    ? _rotating
                        ? '선택중'
                        : restaurantList[_selectedIndex].name
                    : '선택하기',
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _started && _rotating
                        ? Colors.transparent
                        : Colors.purple.withOpacity(0.6),
                    width: _started && _rotating ? 0 : 4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _started
                      ? _rotating
                          ? Image.asset(
                              'assets/spin.gif',
                              fit: BoxFit.fill,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  restaurantList[_selectedIndex].name,
                                  style: const TextStyle(
                                    color: Colors.purple,
                                    fontSize: 35,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  _rotating
                                      ? ''
                                      : restaurantList[_selectedIndex]
                                          .food
                                          .food,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Text(
                                  _rotating
                                      ? ''
                                      : restaurantList[_selectedIndex]
                                          .description,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                      : const Text(
                          '?',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 35,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 50),
              RotationButton(
                onPressed: () {
                  setState(() {
                    if (!_started) {
                      _started = true;
                    }

                    _rotating = true;

                    Future.delayed(const Duration(seconds: 2), () {
                      selected
                          .add(random.nextInt(999999) % restaurantList.length);
                      _rotating = false;
                    });
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _loadProfile() async {
    selected.stream.listen((index) {
      setState(() {
        _selectedIndex = index;
      });
    });
  }
}
