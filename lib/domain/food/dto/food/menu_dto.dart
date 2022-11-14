import 'package:food_ppopgi/domain/domain.dart';

class MenuDto {
  MenuDto({
    required this.restaurant,
    required this.name,
    required this.food,
    this.score = 0,
  });

  final RestaurantDto restaurant;
  final String name;
  final FoodDto food;
  final int score;
}