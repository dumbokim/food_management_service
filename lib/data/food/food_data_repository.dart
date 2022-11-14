import 'package:food_ppopgi/domain/domain.dart';
import 'package:food_ppopgi/domain/food/dto/food/menu_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;

class FoodDataRepository implements FoodRepository {
  FoodDataRepository(
    this.ref, {
    required this.foodProvider,
  });

  final riv.Ref ref;

  final FoodProvider foodProvider;

  final _foods = <FoodDto>[];
  final _restaurants = <RestaurantDto>[];

  final _reviewMap = <int, List<ReviewDto>>{};

  int _selectedRestaurant = -1;

  @override
  List<FoodDto> get getFoodList => _foods;

  @override
  List<RestaurantDto> get getRestaurantList => _restaurants;

  @override
  List<ReviewDto> getReviewList(int restaurantId) {
    return _reviewMap[restaurantId] ?? [];
  }

  @override
  int get selectedRestaurantId => _selectedRestaurant;

  @override
  set setSelectedRestaurant(int restaurantId) {
    _selectedRestaurant = restaurantId;
  }

  @override
  RestaurantDto get selectedRestaurant =>
      _restaurants.firstWhere((element) => element.id == _selectedRestaurant);

  @override
  Future<void> fetchFoodList() async {
    final data = await foodProvider.getFoodList();

    final foodDtoList = data
        .map((foodData) => FoodDto(
            food: foodData?['food'],
            foodType: foodData?['food_type']['food_type']))
        .toList();

    _foods.clear();

    _foods.addAll(foodDtoList);
  }

  @override
  Future<void> fetchRestaurantList() async {
    final data = await foodProvider.getRestaurantList();

    final restaurantDtoList = data
        .map(
          (restaurantData) => RestaurantDto(
            id: restaurantData?['id'],
            name: restaurantData?['name'],
            food: FoodDto(
                food: restaurantData?['food']['food'],
                foodType: restaurantData?['food_type']['food_type']),
            description: restaurantData?['description'],
            latitude: restaurantData?['latitude'],
            longitude: restaurantData?['longitude'],
          ),
        )
        .toList();

    _restaurants.clear();
    _restaurants.addAll(restaurantDtoList);
  }

  @override
  Future<void> fetchRestaurantReviewList(int restaurantId) async {
    final data = await foodProvider.getReviewList(restaurantId);

    final reviewList = data.map(
      (reviewData) {
        final restaurant = _restaurants.firstWhere(
          (restaurant) => restaurant.id == restaurantId,
        );

        return ReviewDto(
          id: reviewData?['id'],
          title: reviewData?['title'],
          content: reviewData?['content'],
          menu: reviewData?['menu'] == null
              ? null
              : MenuDto(
                  restaurant: restaurant,
                  name: reviewData?['menu']['name'],
                  food: restaurant.food,
                ),
          score: reviewData?['score'],
        );
      },
    ).toList();

    _reviewMap.update(
      restaurantId,
      (value) => reviewList,
      ifAbsent: () => reviewList,
    );
  }

  @override
  Future<void> recommendRestaurant() async {
    return await foodProvider.recommendRestaurant();
  }

  @override
  Future<void> registerReview(RegisterReviewDto reviewDto) async {
    return await foodProvider.registerReview(reviewDto);
  }
}
