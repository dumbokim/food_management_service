import 'package:food_ppopgi/domain/food/dto/food/menu_dto.dart';

class RegisterReviewDto {
  RegisterReviewDto({
    required this.title,
    required this.content,
    required this.id,
    required this.score,
  });

  final int id;
  final String title;
  final String content;
  final int score;
}
