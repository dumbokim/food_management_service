import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ppopgi/data/food/food_data_repository.dart';
import 'package:food_ppopgi/data/setting/setting.dart';
import 'package:food_ppopgi/domain/domain.dart';
import 'package:food_ppopgi/domain/food/model/adoption.dart';
import 'package:food_ppopgi/domain/food/model/review.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'food_loading_state.dart';

final database = riv.Provider((ref) => Supabase.instance.client);

final isarProvider = riv.FutureProvider((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([AdoptionSchema, ReviewSchema], directory: dir.path);
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
                            : '????????? ???????????? ???..',
                        style: const TextStyle(fontSize: 15),
                      )
                    ],
                  )
                : (noti is FoodLoadingStateFailed)
                    ? const Text('?????? ?????? ?????????????????????.')
                    : (noti is FoodLoadingStateNeedUpdate)
                        ? TextButton(
                            onPressed: () {
                              launchUrlString(noti.downloadLink);
                            },
                            child: Text('???????????? ???????????? ??????'))
                        : const Text('????????? ???????????? ??????'),
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
    state = FoodLoadingStateLoading('1??? ????????? ???????????? ???..');
    try {
      final downloadLink = await settingRepository.needsUpdate();
      if (downloadLink.isNotEmpty) {
        state = FoodLoadingStateNeedUpdate(downloadLink);
        return;
      }

      await foodRepository.fetchFoodList();
      state = FoodLoadingStateLoading('2??? ????????? ???????????? ???..');
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
