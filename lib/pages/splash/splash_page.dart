import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_management_service/data/food/food_data_repository.dart';
import 'package:food_management_service/data/food/food_network_provider.dart';
import 'package:food_management_service/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'food_loading_state.dart';

final database = riv.Provider((ref) => Supabase.instance.client);

final foodProvider = riv.Provider<FoodProvider>(
    (ref) => FoodNetworkProvider(database: ref.watch(database)));

final foodRepository = riv.Provider<FoodRepository>(
    (ref) => FoodDataRepository(ref, foodProvider: ref.watch(foodProvider)));

final foodLoadingNotifier = riv.StateNotifierProvider.autoDispose<
        FoodLoadingNotifier, FoodLoadingState>(
    (ref) => FoodLoadingNotifier(ref, ref.watch(foodRepository)));

class SplashPage extends riv.ConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, riv.WidgetRef ref) {
    final noti = ref.watch(foodLoadingNotifier);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (noti is FoodLoadingStateFetched) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    });

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/fms.png',
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
    this.repository,
  ) : super(FoodLoadingStateInitial()) {
    load();
  }

  final riv.Ref ref;
  final FoodRepository repository;

  Future<void> load() async {
    state = FoodLoadingStateLoading('1차 데이터 불러오는 중..');
    try {
      await repository.fetchFoodList();
      state = FoodLoadingStateLoading('2차 데이터 불러오는 중..');
      await repository.fetchRestaurantList();
      await repository.fetchRestaurantList();
      state = FoodLoadingStateFetched(
        foodList: repository.getFoodList,
        restaurantList: repository.getRestaurantList,
      );
    } catch (e) {
      state = FoodLoadingStateFailed();
    }
  }
}
