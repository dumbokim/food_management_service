import 'package:isar/isar.dart';

part 'adoption.g.dart';

@Collection()
class Adoption {
  Id id = Isar.autoIncrement;

  @Index()
  int? restaurantId;

  String? restaurant;

  @Index()
  int? adoptedDate;
}