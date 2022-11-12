import '../dto.dart';

class RestaurantDto {
  RestaurantDto({
    required this.id,
    required this.name,
    required this.food,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final String name;
  final FoodDto food;
  final String description;
  final double latitude;
  final double longitude;
}
