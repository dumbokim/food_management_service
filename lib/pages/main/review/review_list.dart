import 'package:flutter/material.dart';
import 'package:food_ppopgi/data/food/food_data_repository.dart';
import 'package:food_ppopgi/domain/food/model/review.dart';
import 'package:food_ppopgi/pages/main/main.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../common/common.dart';

class ReviewListPage extends ConsumerWidget {
  ReviewListPage({Key? key}) : super(key: key);

  final notifier = StateNotifierProvider.autoDispose<ReviewListStateNotifier,
      ReviewListState>((ref) {
    return ReviewListStateNotifier(
      ref: ref,
      repository: ref.watch(foodRepository),
    );
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
        onTap: () async {
          _showAlertDialog(
            context,
            ref,
            read: read,
          );
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
                      '등록된 리뷰가 없어요\n먼저 리뷰를 등록해보세요!',
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
                          return GestureDetector(
                            onLongPress: () async => _showDeleteDialog(
                                context, ref,
                                id: state.reviewList[index].id),
                            child: Container(
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

  _showDeleteDialog(
    BuildContext context,
    WidgetRef ref, {
    required int id,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text(
                  '리뷰를 차단하시겠습니까?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('취소')),
                    TextButton(
                        onPressed: () async {
                          final isar = await ref.read(isarProvider.future);
                          final reviewData = Review()
                            ..reviewId = id
                            ..deletedDate =
                                DateTime.now().millisecondsSinceEpoch;
                          try {
                            await isar.writeTxn(
                                () async => await isar.reviews.put(reviewData));
                            ref.refresh(notifier);
                          } catch (e) {
                            showDefaultSnackBar(context,
                                content: '오류가 발생했습니다.');
                          } finally {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('차단')),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showAlertDialog(
    BuildContext context,
    WidgetRef ref, {
    required ReviewListStateNotifier read,
  }) async {
    final pref = await SharedPreferences.getInstance();

    final isConsent = pref.getBool('reviewTermAccept') ?? false;

    if (isConsent) {
      Navigator.pushNamed(context, '/restaurant/review/register').then((value) {
        if (value == null) {
          return;
        }
        read.load();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    '이용 약관에 따라 불쾌감을 주는 리뷰의 경우, 서비스 이용의 불이익을 받을 수 있습니다.\n해당 약관에 동의하시겠습니까?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      launchUrlString(
                          'https://tar-cycle-2b3.notion.site/ed28d6c59a55417199050978caf8497a');
                    },
                    child: const Text(
                      '이용 약관 확인',
                      style: TextStyle(fontSize: 15, color: Color(0xFF6508DF)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('취소')),
                      TextButton(
                          onPressed: () async {
                            Navigator.pushNamed(
                                    context, '/restaurant/review/register')
                                .then((value) {
                              if (value == null) {
                                return;
                              }
                              read.load();
                            });
                          },
                          child: const Text('수락')),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
