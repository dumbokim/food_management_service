import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ppopgi/data/food/food_data_repository.dart';
import 'package:food_ppopgi/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'register_review_state.dart';

class RegisterReviewPage extends ConsumerWidget {
  RegisterReviewPage({Key? key}) : super(key: key);

  final _contentFocus = FocusNode();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final notifier = StateNotifierProvider.autoDispose<
      RegisterReviewStateNotifier, RegisterReviewState>(
    (ref) => RegisterReviewStateNotifier(ref.watch(foodRepository)),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(foodRepository);

    final state = ref.watch(notifier);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (state is RegisterReviewStateRegistered) {
        Navigator.pop(context, state);
      }
    });

    final read = ref.read(notifier.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('리뷰 등록'),
            Text(
              repository.selectedRestaurant.name,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      '리뷰 남기기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _contentFocus.requestFocus(),
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: _contentController,
                      focusNode: _contentFocus,
                      style: TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              const Text('점수 선택'),
                              const SizedBox(height: 20),
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                    initialItem: state.score,
                                  ),
                                  diameterRatio: 2,
                                  itemExtent: 60,
                                  onSelectedItemChanged: (int index) {
                                    read.selectScore(index);
                                  },
                                  children: List.generate(
                                      101, (index) => Text('$index')),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('확인'),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(
                        '점수 : ${state.score}',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    read.register(
                      context,
                      title: _titleController.text,
                      content: _contentController.text,
                    );
                  },
                  child: const Text(
                    '등록하기',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (state is RegisterReviewStateLoading)
            Positioned.fill(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

class RegisterReviewStateNotifier extends StateNotifier<RegisterReviewState> {
  RegisterReviewStateNotifier(this.repository)
      : super(RegisterReviewStateInitial(0));

  final FoodRepository repository;

  void selectScore(int score) {
    state = RegisterReivewSelectScore(score);
  }

  Future<void> register(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('비어있는 텍스트가 있습니다.')));
    }

    state = RegisterReviewStateLoading(state.score);
    try {
      await repository.registerReview(
        RegisterReviewDto(
          title: title,
          content: content,
          id: repository.selectedRestaurantId,
          score: state.score,
        ),
      );
      state = RegisterReviewStateRegistered(state.score);
    } catch (e) {
      state = RegisterReviewStateFailed(state.score);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('오류가 발생했어요. 재시도 해주세요.'),
        ),
      );
    }
  }
}
