import 'dto/dto.dart';

abstract class FoodRepository {
  List<FoodDto> get getFoodList;

  List<RestaurantDto> get getRestaurantList;

  List<ReviewDto> getReviewList(int restaurantId);

  set setSelectedRestaurant(int restaurantId);

  int get selectedRestaurantId;

  RestaurantDto get selectedRestaurant;

  Future<void> adoptRestaurant(int restaurantId);

  Future<void> fetchFoodList();

  Future<void> fetchRestaurantList();

  Future<void> fetchRestaurantReviewList(int restaurantId);

  Future<void> recommendRestaurant();

  Future<void> registerReview(RegisterReviewDto reviewDto);

  Future<void> registerRequest(String content);
}
