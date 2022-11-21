import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/common/common.dart';
import 'package:food_ppopgi/data/data.dart';
import 'package:food_ppopgi/domain/food/model/adoption.dart';
import 'package:food_ppopgi/pages/main/random/random.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../domain/domain.dart';

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

  bool _adoptButtonDisabled = false;

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
                                        restaurantList[_selectedIndex].name,
                                        style: const TextStyle(
                                          color:defaultColor,
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
                                        textAlign: TextAlign.center,
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
                      if (!_rotating)
                        RotationButton(
                          text: '돌리기',
                          onPressed: () async {
                            setState(() {
                              if (!_started) {
                                _started = true;
                              }

                              _rotating = true;
                              _adoptButtonDisabled = false;
                            });

                            final isar = await ref.read(isarProvider.future);

                            final adoptedList = await isar.adoptions
                                .where()
                                .adoptedDateGreaterThan(DateTime.now()
                                    .subtract(Duration(days: 7))
                                    .millisecondsSinceEpoch)
                                .findAll();

                            final adoptedIds =
                                adoptedList.map((e) => e.restaurantId);

                            final datas =
                                List<RestaurantDto>.from(restaurantList)
                                    .where((element) =>
                                        !adoptedIds.contains(element.id))
                                    .toList();

                            datas.shuffle();
                            datas.shuffle();

                            final a = restaurantList.indexWhere(
                                (element) => element.id == datas[0].id);

                            selected.add(a);

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
                          disabled: _adoptButtonDisabled,
                          onPressed: () async {
                            try {
                              final targetId =
                                  restaurantList[_selectedIndex].id;

                              setState(() {
                                _adoptButtonDisabled = true;
                              });

                              showDefaultSnackBar(context,
                                  content: '메뉴가 채택되었습니다!');

                              final isar = await ref.read(isarProvider.future);

                              final adoptionData = Adoption()
                                ..restaurantId = targetId
                                ..restaurant =
                                    restaurantList[_selectedIndex].name
                                ..adoptedDate =
                                    (DateTime.now().millisecondsSinceEpoch);

                              await isar.writeTxn(() async =>
                                  await isar.adoptions.put(adoptionData));

                              await repository.adoptRestaurant(targetId);
                            } catch (e) {
                              developer.log('error occurred: $e');
                              showDefaultSnackBar(
                                context,
                                content: '오류가 발생했습니다.\n다시 시도해주세요.',
                              );

                              setState(() {
                                _adoptButtonDisabled = false;
                              });
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
