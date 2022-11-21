import '../../domain/domain.dart';

class FoodLoadingState {}

class FoodLoadingStateInitial extends FoodLoadingState {}

class FoodLoadingStateLoading extends FoodLoadingState {
  FoodLoadingStateLoading(this.status);

  final String status;
}

class FoodLoadingStateFailed extends FoodLoadingState {}

class FoodLoadingStateNeedUpdate extends FoodLoadingState {
  FoodLoadingStateNeedUpdate(this.downloadLink);

  final String downloadLink;
}

class FoodLoadingStateFetched extends FoodLoadingState {
  FoodLoadingStateFetched({
    required this.foodList,
    required this.restaurantList,
  });

  final List<FoodDto> foodList;
  final List<RestaurantDto> restaurantList;
}
