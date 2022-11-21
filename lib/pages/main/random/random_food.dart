import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/common/common.dart';
import 'package:food_ppopgi/pages/main/random/random.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
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
  Timer? _timer;

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
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_timer?.isActive ?? false) {
                        _timer?.cancel;
                      }

                      if (_rotating == true) {
                        setState(() {
                          _rotating = false;
                        });
                      }
                    },
                    child: Container(
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
                                        foodList[_selectedIndex].food,
                                        style: const TextStyle(
                                          color: defaultColor,
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
                                  color: defaultColor,
                                  fontSize: 35,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotationButton(
                        text: '돌리기',
                        onPressed: () {
                          setState(() {
                            if (!_started) {
                              _started = true;
                            }

                            _rotating = true;
                          });

                          selected
                              .add(random.nextInt(999999) % foodList.length);

                          _timer = Timer(const Duration(seconds: 2), () {
                            setState(() {
                              _rotating = false;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: AdmobBannerView(),
            ),
          ],
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
