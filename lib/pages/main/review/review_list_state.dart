import 'package:food_ppopgi/domain/domain.dart';

class ReviewListState {}

class ReviewListStateInitial extends ReviewListState {}

class ReviewListStateLoading extends ReviewListState {}

class ReviewListStateFailed extends ReviewListState {}

class ReviewListStateFetched extends ReviewListState {
  ReviewListStateFetched(this.reviewList);

  final List<ReviewDto> reviewList;
}
