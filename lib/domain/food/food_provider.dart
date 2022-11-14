import 'dto/food/register_review_dto.dart';

abstract class FoodProvider {
  Future<List> getFoodList();

  Future<List> getRestaurantList();

  Future<List> getReviewList(int restaurantId);

  Future recommendRestaurant();

  Future registerReview(RegisterReviewDto reviewDto);
}