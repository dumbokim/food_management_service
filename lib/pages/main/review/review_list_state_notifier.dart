import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import 'review_list_state.dart';

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
