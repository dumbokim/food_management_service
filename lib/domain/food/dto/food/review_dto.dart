import 'package:food_management_service/domain/food/dto/food/menu_dto.dart';

class ReviewDto {
  ReviewDto({
    required this.id,
    this.reviewer,
    required this.title,
    required this.content,
    this.menu,
    this.score = 0,
  });

  final int id;
  final String? reviewer;
  final String title;
  final String content;
  final MenuDto? menu;
  final int score;
}
