import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/common/common.dart';
import 'package:food_ppopgi/pages/main/random/random.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';

class RandomMenuPage extends ConsumerStatefulWidget {
  const RandomMenuPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RandomMenuPage> createState() => _RandomMenuPageState();
}

class _RandomMenuPageState extends ConsumerState<RandomMenuPage> {
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

  final _items = <FoodDto>[];

  String _selected = '선택하기';
  String _selectedType = '...';
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selected,
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
                        : defaultColor.withOpacity(0.6),
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
                                  _items[_selectedIndex].food,
                                  style: const TextStyle(
                                    color: defaultColor,
                                    fontSize: 35,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  _selectedType,
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
                            color: defaultColor,
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
                    _selected = '선택중...';
                    _selectedType = '';

                    Future.delayed(const Duration(seconds: 2), () {
                      selected.add(random.nextInt(999999) % _items.length);
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
    final repository = ref.watch(foodRepository);

    setState(() {
      _items.clear();
      _items.addAll(repository.getFoodList);
    });

    selected.stream.listen((index) {
      setState(() {
        _selectedIndex = index;
        _selected = _items[_selectedIndex].food;
        _selectedType = _items[_selectedIndex].foodType;
      });
    });
  }
}
