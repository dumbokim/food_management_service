import 'package:isar/isar.dart';

part 'review.g.dart';

@Collection()
class Review {
  Id id = Isar.autoIncrement;

  @Index()
  int? reviewId;

  @Index()
  int? deletedDate;
}