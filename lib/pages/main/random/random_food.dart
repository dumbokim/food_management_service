import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_management_service/pages/main/random/random.dart';
import 'package:food_management_service/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RandomFoodPage extends ConsumerStatefulWidget {
  const RandomFoodPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RandomFoodPage> createState() => _RandomFoodPageState();
}

class _RandomFoodPageState extends ConsumerState<RandomFoodPage> {
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
    final foodList = repository.getFoodList;
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
                        : foodList[_selectedIndex].food
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
                                  foodList[_selectedIndex].food,
                                  style: const TextStyle(
                                    color: Colors.purple,
                                    fontSize: 35,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  foodList[_selectedIndex].foodType,
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
                      selected.add(random.nextInt(999999) % foodList.length);
                      _rotating = false;
                    });
                  });
                },
              )
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