import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

// Run 'flutter pub run build_runner build' to create generated dart classes for firestore
// If regenerating file, remove .toIso8601String methods on dates. It will break when uploading to firebase

// this is temporary, can be updated
@JsonSerializable()
class User {
  String userID;
  String firstName;
  String lastName;
  String gender;
  int age;
  String biography;
  String imageURL;

  User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    this.gender = '',
    this.age = 0,
    this.biography = '',
    this.imageURL = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Schedule {
  String scheduleID;
  String userID;
  List<String> tripList;

  Schedule({
    required this.scheduleID,
    required this.userID,
    this.tripList = const <String>[],
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

}@JsonSerializable()
class Trip {
  String tripID;
  String locationID;
  String scheduleID;
  String userID;
  String courseName;
  int startingZone;
  int endingZone;
  DateTime departureTime;

  Trip({
    required this.tripID,
    required this.locationID,
    required this.scheduleID,
    required this.userID,
    this.courseName = '',
    this.startingZone = 0,
    this.endingZone = 0,
    required this.departureTime
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson() => _$TripToJson(this);
}

@JsonSerializable()
class Location {
  String locationID;
  String zoneID;
  String locationName;


  Location({
    required this.locationID,
    required this.zoneID,
    this.locationName = '',
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
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