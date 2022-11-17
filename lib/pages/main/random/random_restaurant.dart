import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/common/common.dart';
import 'package:food_ppopgi/pages/main/random/random.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final restaurantList = repository.getRestaurantList;

    return CupertinoTabView(
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
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

                          selected.add(
                              random.nextInt(999999) % restaurantList.length);

                          _timer = Timer(const Duration(seconds: 2), () {
                            setState(() {
                              _rotating = false;
                            });
                          });
                        },
                      ),
                      if (_started && !_rotating) ...[
                        SizedBox(width: 20),
                        RotationButton(
                          text: '채택',
                          onPressed: () async {
                            try {
                              final targetId =
                                  restaurantList[_selectedIndex].id;

                              await repository.adoptRestaurant(targetId);

                              showDefaultSnackBar(context,
                                  content: '메뉴가 채택되었습니다!');

                              final pref =
                                  await SharedPreferences.getInstance();

                              final adoptedRestaurants =
                                  pref.getStringList('adoptedRestaurants') ??
                                      [];

                              if (adoptedRestaurants.contains('$targetId')) {
                                return;
                              }

                              adoptedRestaurants.add('$targetId');

                              await pref.setStringList(
                                  'adoptedRestaurants', adoptedRestaurants);
                            } catch (e) {
                              developer.log('error occurred: $e');
                              showDefaultSnackBar(
                                context,
                                content: '오류가 발생했습니다.\n다시 시도해주세요.',
                              );
                            }
                          },
                        ),
                      ]
                    ],
                  )
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
