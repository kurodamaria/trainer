import 'package:hive_flutter/hive_flutter.dart';

part 'test.g.dart';

@HiveType(typeId: 8)
class Person extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  HiveList pets;

  Person({required this.name, required this.pets});
}

@HiveType(typeId: 9)
class Pokemon extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(2)
  bool sex;

  Pokemon({required this.name, required this.sex});
}
