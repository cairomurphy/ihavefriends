import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

// Run 'flutter pub run build_runner build' to create generated dart classes for firestore
// If regenerating file, remove .toIso8601String methods on dates. It will break when uploading to firebase

// this is temporary, can be updated
@JsonSerializable()
class Student {
  String id;
  String name;
  String scheduleId;
  String phone;

  Student({
    required this.id,
    this.name = '',
    this.scheduleId = '',
    this.phone = '',
  });

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

// EXAMPLE //
// I always recommend making as few things required as possible
// @JsonSerializable()
// class Recipe {
//   String id;
//   String name;
//   String className;
//   List<String> ingredientAmounts;
//   int number;
//
//   Recipe({
//     required this.id,
//     required this.name,
//     this.className = 'Main',
//     this.ingredientAmounts = const <String>[],
//     this.number = 0,
//   });
//
//   factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
//   Map<String, dynamic> toJson() => _$RecipeToJson(this);
// }