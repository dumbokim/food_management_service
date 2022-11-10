import '../../data/data.dart';

class FoodLoadingState {}

class FoodLoadingStateInitial extends FoodLoadingState {}

class FoodLoadingStateLoading extends FoodLoadingState {
  FoodLoadingStateLoading(this.status);

  final String status;
}

class FoodLoadingStateFailed extends FoodLoadingState {}

class FoodLoadingStateFetched extends FoodLoadingState {
  FoodLoadingStateFetched({
    required this.foodList,
    required this.restaurantList,
  });

  final List<FoodDto> foodList;
  final List<RestaurantDto> restaurantList;
}
