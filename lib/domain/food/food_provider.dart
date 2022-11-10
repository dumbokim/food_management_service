abstract class FoodProvider {
  Future<List> getFoodList();

  Future<List> getRestaurantList();

  Future recommendRestaurant();

  Future registerReview();
}