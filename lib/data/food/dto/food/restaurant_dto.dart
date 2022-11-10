import 'package:food_management_service/data/data.dart';

class RestaurantDto {
  RestaurantDto({
    required this.name,
    required this.food,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final FoodDto food;
  final String description;
  final double latitude;
  final double longitude;
}
