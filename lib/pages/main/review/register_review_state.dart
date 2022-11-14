class RegisterReviewState {
  RegisterReviewState(this.score);

  final int score;
}

class RegisterReviewStateInitial extends RegisterReviewState {
  RegisterReviewStateInitial(int score) : super(score);
}

class RegisterReviewStateLoading extends RegisterReviewState {
  RegisterReviewStateLoading(int score) : super(score);
}

class RegisterReivewSelectScore extends RegisterReviewState {
  RegisterReivewSelectScore(int score) : super(score);

}

class RegisterReviewStateFailed extends RegisterReviewState {
  RegisterReviewStateFailed(int score) : super(score);
}

class RegisterReviewStateRegistered extends RegisterReviewState {
  RegisterReviewStateRegistered(int score) : super(score);
}
