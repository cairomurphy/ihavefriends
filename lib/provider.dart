import 'package:flutter/material.dart';
import 'package:ihavefriends/auth.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ihavefriends/models/utility_models.dart';

final _firestore = FirebaseFirestore.instance;

class AppProvider extends ChangeNotifier {
  AppProvider();

  Future<List<Trip>> findWalkingBuddies() async {
    /// Find schedule matches, grab the schedules that the current student matches with,
    /// order them chronologically starting with today's weekday, return list
    /// NOTE: DO NOT return the list of the current student's trips. Return the trips with different student's IDs
    //TODO: find walking buddies
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (error) {
      debugPrint(error.toString());
    }

    //returning dummy data
    return [
      Trip(
          tripID: '1',
          startingLocationID: '1',
          endingLocationID: '2',
          scheduleID: '1',
          userID: '1',
          departureTime: DateTime.now()),
      Trip(
          tripID: '1',
          startingLocationID: '2',
          endingLocationID: '3',
          scheduleID: '1',
          userID: '1',
          departureTime: DateTime.now()),
      Trip(
          tripID: '1',
          startingLocationID: '3',
          endingLocationID: '4',
          scheduleID: '1',
          userID: '1',
          departureTime: DateTime.now())
    ];
  }

  Future<AppUser?> fetchBuddy(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();
      if (doc.exists) {
        AppUser appUser = AppUser.fromJson(doc.data()!);
        return appUser;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<Location?> fetchLocation(String id) async {
    try {
      final doc = await _firestore.collection('locations').doc(id).get();
      if (doc.exists) {
        Location location = Location.fromJson(doc.data()!);
        return location;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<void> addUserToFirestore(String uid) async {
    try {
      AppUser appUser = AppUser(userID: uid, firstName: "", lastName: "");
      var ref = _firestore.collection('users').doc(uid);
      await ref.set(appUser.toJson());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<List<Location>?> fetchLocations() async {
    try {
      final doc = await _firestore.collection('locations').get();
      if (doc.docs.isNotEmpty) {
        List<Location> locations = doc.docs.map((doc) => Location.fromJson(doc.data())).toList();
        return locations;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<void> createSchedule(List<StudentClass> classes) async {
    try {
      String? userID = Auth().currentUser?.uid;
      String appUserID = userID ?? "";
      List<Trip> trips = [];

      final scheduleRef = _firestore.collection('schedules').doc();

      for (var i = 0; i < classes.length - 1; i++) {
        if (classes[i].endTime.weekday == classes[i+1].endTime.weekday) {
          trips.add(Trip(
              tripID: '',
              startingLocationID: classes[i].location.locationID,
              endingLocationID: classes[i + 1].location.locationID,
              scheduleID: scheduleRef.id,
              userID: appUserID,
              courseName: classes[i].name,
              startingZone: classes[i].location.zoneID,
              endingZone: classes[i + 1].location.zoneID,
              departureTime: classes[i].endTime));
        }
      }

      for (var trip in trips) {
        final tripRef = _firestore.collection('trips').doc();
        trip.tripID = tripRef.id;
        await tripRef.set(trip.toJson());
      }

      List<String> tripIds = trips.map((e) => e.tripID).toList();

      Schedule schedule = Schedule(scheduleID: scheduleRef.id, userID: appUserID, tripList: tripIds);
      await scheduleRef.set(schedule.toJson());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // Example write to Firestore
  // Future<void> editProfile(Student student) async {
  //   try {
  //     var ref = _firestore.collection('students').doc(student.id);
  //     await ref.set(student.toJson());
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }

  // Example read Firestore
  // Future<Student?> getStudent(String id) async {
  //   try {
  //     var doc = await _firestore.collection('students').doc(id).get();
  //     if (doc.exists) {
  //       return Student.fromJson(doc.data()!);
  //     }
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  //   return null;
  // }
}
