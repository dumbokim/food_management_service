import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ppopgi/pages/main/main.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/common.dart';

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
      floatingActionButton: RegisterButton(
        onTap: () {
          Navigator.pushNamed(context, '/restaurant/review/register')
              .then((value) {
            if (value == null) {
              return;
            }
            read.load();
          });
        },
        text: '리뷰 작성',
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
                  : RefreshIndicator(
                      onRefresh: () async {
                        ref.refresh(notifier);
                      },
                      child: ListView.separated(
                        itemCount: state.reviewList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: defaultColor,
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
                                        color: defaultColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      List.generate(
                                          state.reviewList[index].score,
                                          (index) => '🍚').join(),
                                      style: const TextStyle(
                                        color: defaultColor,
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
                        },
                      ),
                    )
              : const Center(
                  child: Text('문제가 발생했습니다.'),
                ),
    );
  }
}
