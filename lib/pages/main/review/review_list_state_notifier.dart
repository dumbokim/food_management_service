import 'package:food_ppopgi/domain/food/model/review.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../domain/domain.dart';
import '../../splash/splash_page.dart';
import 'review_list_state.dart';

class ReviewListStateNotifier extends StateNotifier<ReviewListState> {
  ReviewListStateNotifier({
    required this.ref,
    required this.repository,
  }) : super(ReviewListStateInitial()) {
    load();
  }

  final AutoDisposeStateNotifierProviderRef ref;
  final FoodRepository repository;

  Future<void> load() async {
    final isar = await ref.read(isarProvider.future);

    final deletedReviews =
        (await isar.reviews.where().findAll()).map((e) => e.reviewId);

    state = ReviewListStateLoading();
    try {
      await repository
          .fetchRestaurantReviewList(repository.selectedRestaurantId);

      final a = repository.getReviewList(repository.selectedRestaurantId);

      state = ReviewListStateFetched(
          a.where((e) => !deletedReviews.contains(e.id)).toList());
    } catch (e) {
      state = ReviewListStateFailed();
    }
  }

  void getReviewList() {
    state = ReviewListStateFetched(
        repository.getReviewList(repository.selectedRestaurantId));
  }
}
