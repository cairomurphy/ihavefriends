import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

// Run 'flutter pub run build_runner build' to create generated dart classes for firestore
// If regenerating file, remove .toIso8601String methods on dates. It will break when uploading to firebase

// this is temporary, can be updated
@JsonSerializable()
class User {
  String UserID;
  String FirstName;
  String LastName;
  String Gender;
  int Age;
  String Biography;
  String ImageURL;

  Student({
    required this.UserID,
    required this.FirstName = '',
    this.LastName = '',
    this.Gender = '',
    this.Age = 0,
    this.Biography = '',
    this.ImageURL = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Schedule {
  String ScheduleID;
  String UserID;
  [] TripList;

  Schedule({
    required this.ScheudleID,
    required this.UserID = '',
    this.TripList = [],
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

}@JsonSerializable()
class User {
  String UserID;
  String FirstName;
  String LastName;
  String Gender;
  int Age;
  String Biography;
  String ImageURL;

  Student({
    required this.UserID,
    required this.FirstName = '',
    this.LastName = '',
    this.Gender = '',
    this.Age = 0,
    this.Biography = '',
    this.ImageURL = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
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