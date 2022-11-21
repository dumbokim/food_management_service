import 'package:food_ppopgi/domain/food/model/adoption.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';

class FoodNetworkProvider implements FoodProvider {
  FoodNetworkProvider({
    required this.database,
  });

  final SupabaseClient database;

  @override
  Future<List> getFoodList() async {
    final data =
        await database.from('food').select('*, food_type!inner(*)') as List?;

    return data ?? [];
  }

  @override
  Future<List> getRestaurantList() async {
    final data = await database
        .from('restaurant')
        .select('*, food_type!inner(*), food!inner(*)') as List?;

    return data ?? [];
  }

  @override
  Future<List> getReviewList(int restaurantId) async {
    final data = await database
        .from('review')
        .select('id, title, content, menu, score')
        .eq('restaurant', restaurantId) as List?;

    return data ?? [];
  }

  @override
  Future recommendRestaurant() async {}

  @override
  Future registerReview(RegisterReviewDto reviewDto) async {
    await database.from('review').insert({
      'restaurant': reviewDto.id,
      'title': reviewDto.title,
      'content': reviewDto.content,
      'score': reviewDto.score,
    });
  }

  @override
  Future adoptRestaurant(int restaurantId) async {
    await database.from('restaurant_adoption').insert({
      'restaurant_id': restaurantId,
    });
  }

  @override
  Future<void> registerRequest(String content) async {
    await database.from('request').insert({
      'content' : content,
    });
  }
}

final isarProvider = FutureProvider((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([AdoptionSchema], directory: dir.path);
});
