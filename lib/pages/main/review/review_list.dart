import 'package:flutter/material.dart';
import 'package:food_ppopgi/domain/domain.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../list/list.dart';

class ReviewListPage extends ConsumerWidget {
  ReviewListPage({Key? key}) : super(key: key);

  final notifier = StateNotifierProvider.autoDispose<ReviewListStateNotifier,
      ReviewListState>((ref) {
    return ReviewListStateNotifier(ref.watch(foodRepository));
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(foodRepository);

    final state = ref.watch(notifier);

    final read = ref.read(notifier.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(repository.selectedRestaurant.name),
        centerTitle: true,
      ),
      floatingActionButton: Material(
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.purple,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/restaurant/review/register')
                  .then((value) {
                if (value == null) {
                  return;
                }
                read.load();
              });
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Icon(
                Icons.add_comment_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      body: (state is ReviewListStateLoading || state is ReviewListStateInitial)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (state is ReviewListStateFetched)
              ? (state.reviewList.isEmpty)
                  ? const Center(
                      child: Text(
                      '등록된 리뷰가 없어요\n먼저 리뷰를 보세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, height: 2, color: Colors.grey),
                    ))
                  : ListView.separated(
                      itemCount: state.reviewList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.purple,
                          thickness: 1.5,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: const BoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.reviewList[index].title,
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '( ${state.reviewList[index].score}점)',
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 7),
                              Text(
                                state.reviewList[index].content,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
              : const Center(
                  child: Text('문제가 발생했습니다.'),
                ),
    );
  }
}

class ReviewListStateNotifier extends StateNotifier<ReviewListState> {
  ReviewListStateNotifier(
    this.repository,
  ) : super(ReviewListStateInitial()) {
    load();
  }

  final FoodRepository repository;

  Future<void> load() async {
    state = ReviewListStateLoading();
    try {
      await repository
          .fetchRestaurantReviewList(repository.selectedRestaurantId);
      state = ReviewListStateFetched(
          repository.getReviewList(repository.selectedRestaurantId));
    } catch (e) {
      state = ReviewListStateFailed();
    }
  }

  void getReviewList() {
    state = ReviewListStateFetched(
        repository.getReviewList(repository.selectedRestaurantId));
  }
}
