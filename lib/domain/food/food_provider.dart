import 'dto/food/register_review_dto.dart';
import 'dto/food/report_dto.dart';

abstract class FoodProvider {
  Future<List> getFoodList();

  Future<List> getRestaurantList();

  Future<List> getReviewList(int restaurantId);

  Future recommendRestaurant();

  Future registerReview(RegisterReviewDto reviewDto);

  Future adoptRestaurant(int restaurantId);

  Future<void> registerRequest(String content);

  Future<void> reportReview(ReportDto reportDto);
}