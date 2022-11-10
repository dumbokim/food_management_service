import 'package:food_management_service/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'dto/dto.dart';

class FoodDataRepository implements FoodRepository {
  FoodDataRepository(
    this.ref, {
    required this.foodProvider,
  });

  final riv.Ref ref;

  final FoodProvider foodProvider;

  final _foods = <FoodDto>[];
  final _restaurants = <RestaurantDto>[];

  @override
  List<FoodDto> get getFoodList => _foods;

  @override
  List<RestaurantDto> get getRestaurantList => _restaurants;

  @override
  Future<List<FoodDto>> fetchFoodList() async {
    final data = await foodProvider.getFoodList();

    final foodDtoList = data
        .map((foodData) => FoodDto(
            food: foodData?['food'],
            foodType: foodData?['food_type']['food_type']))
        .toList();

    _foods.clear();

    _foods.addAll(foodDtoList);

    return foodDtoList;
  }

  @override
  Future<List<RestaurantDto>> fetchRestaurantList() async {
    final data = await foodProvider.getRestaurantList();

    final restaurantDtoList = data
        .map(
          (restaurantData) => RestaurantDto(
              name: restaurantData?['name'],
              food: FoodDto(
                  food: restaurantData?['food']['food'],
                  foodType: restaurantData?['food_type']['food_type']),
              description: restaurantData?['description'],
              latitude: restaurantData?['latitude'],
              longitude: restaurantData?['longitude']),
        )
        .toList();

    _restaurants.clear();
    _restaurants.addAll(restaurantDtoList);

    return restaurantDtoList;
  }

  @override
  Future recommendRestaurant() async {
    return await foodProvider.recommendRestaurant();
  }

  @override
  Future registerReview() async {
    return await foodProvider.registerReview();
  }
}
