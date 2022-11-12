abstract class FoodProvider {
  Future<List> getFoodList();

  Future<List> getRestaurantList();

  Future<List> getReviewList(int restaurantId);

  Future recommendRestaurant();

  Future registerReview();
}