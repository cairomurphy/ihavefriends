// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      userID: json['userID'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      biography: json['biography'] as String? ?? '',
      imageURL: json['imageURL'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'userID': instance.userID,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'age': instance.age,
      'biography': instance.biography,
      'imageURL': instance.imageURL,
      'phoneNumber': instance.phoneNumber,
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      scheduleID: json['scheduleID'] as String,
      userID: json['userID'] as String,
      tripList: (json['tripList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'scheduleID': instance.scheduleID,
      'userID': instance.userID,
      'tripList': instance.tripList,
    };

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      tripID: json['tripID'] as String,
      startingLocationID: json['startingLocationID'] as String,
      endingLocationID: json['endingLocationID'] as String,
      scheduleID: json['scheduleID'] as String,
      userID: json['userID'] as String,
      courseName: json['courseName'] as String? ?? '',
      startingZone: json['startingZone'] as int? ?? 0,
      endingZone: json['endingZone'] as int? ?? 0,
      departureTime: DateTime.parse(json['departureTime'] as String),
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'tripID': instance.tripID,
      'startingLocationID': instance.startingLocationID,
      'endingLocationID': instance.endingLocationID,
      'scheduleID': instance.scheduleID,
      'userID': instance.userID,
      'courseName': instance.courseName,
      'startingZone': instance.startingZone,
      'endingZone': instance.endingZone,
      'departureTime': instance.departureTime.toIso8601String(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      locationID: json['locationID'] as String,
      zoneID: json['zoneID'] as String,
      locationName: json['locationName'] as String? ?? '',
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'locationID': instance.locationID,
      'zoneID': instance.zoneID,
      'locationName': instance.locationName,
    };
