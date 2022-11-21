import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ppopgi/data/food/food_data_repository.dart';
import 'package:food_ppopgi/data/food/food_network_provider.dart';
import 'package:food_ppopgi/data/setting/setting.dart';
import 'package:food_ppopgi/domain/domain.dart';
import 'package:food_ppopgi/domain/food/model/adoption.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'food_loading_state.dart';

final database = riv.Provider((ref) => Supabase.instance.client);

final isarProvider = riv.FutureProvider((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([AdoptionSchema], directory: dir.path);
});

final foodLoadingNotifier = riv.StateNotifierProvider
    .autoDispose<FoodLoadingNotifier, FoodLoadingState>(
        (ref) => FoodLoadingNotifier(
              ref,
              ref.watch(foodRepository),
              ref.watch(settingRepository),
            ));

class SplashPage extends riv.ConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, riv.WidgetRef ref) {
    final noti = ref.watch(foodLoadingNotifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (noti is FoodLoadingStateFetched) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    });

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/logo.svg',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            child: (noti is FoodLoadingStateLoading ||
                    noti is FoodLoadingStateInitial)
                ? Column(
                    children: [
                      const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator()),
                      const SizedBox(height: 20),
                      Text(
                        noti is FoodLoadingStateLoading
                            ? noti.status
                            : '데이터 불러오는 중..',
                        style: const TextStyle(fontSize: 15),
                      )
                    ],
                  )
                : (noti is FoodLoadingStateFailed)
                    ? const Text('앱을 다시 실행시켜주세요.')
                    : (noti is FoodLoadingStateNeedUpdate)
                        ? TextButton(
                            onPressed: () {
                              launchUrlString(noti.downloadLink);
                            },
                            child: Text('업데이트 다운로드 하기'))
                        : const Text('데이터 불러오기 완료'),
            bottom: 150,
          )
        ],
      ),
    );
  }
}

class FoodLoadingNotifier extends riv.StateNotifier<FoodLoadingState> {
  FoodLoadingNotifier(
    this.ref,
    this.foodRepository,
    this.settingRepository,
  ) : super(FoodLoadingStateInitial()) {
    load();
  }

  final riv.Ref ref;
  final FoodRepository foodRepository;
  final SettingRepository settingRepository;

  Future<void> load() async {
    state = FoodLoadingStateLoading('1차 데이터 불러오는 중..');
    try {
      final downloadLink = await settingRepository.needsUpdate();
      if (downloadLink.isNotEmpty) {
        state = FoodLoadingStateNeedUpdate(downloadLink);
        return;
      }

      await foodRepository.fetchFoodList();
      state = FoodLoadingStateLoading('2차 데이터 불러오는 중..');
      await foodRepository.fetchRestaurantList();
      state = FoodLoadingStateFetched(
        foodList: foodRepository.getFoodList,
        restaurantList: foodRepository.getRestaurantList,
      );
    } catch (e) {
      state = FoodLoadingStateFailed();
    }
  }
}
