import '../../data/data.dart';

abstract class FoodRepository {
  List<FoodDto> get getFoodList;

  List<RestaurantDto> get getRestaurantList;

  Future<List<FoodDto>> fetchFoodList();

  Future<List<RestaurantDto>> fetchRestaurantList();

  Future recommendRestaurant();

  Future registerReview();
}
