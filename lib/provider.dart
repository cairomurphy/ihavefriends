import 'package:flutter/material.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class AppProvider extends ChangeNotifier {
  AppProvider();

  Future<List<String>> findWalkingBuddies() async {
    /// Find schedule matches, order them chronologically starting with today's weekday, return list
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (error) {
      debugPrint(error.toString());
    }
    return ['1', '2', '3'];
  }

  Future<String> fetchBuddy(String id) async {
    /// Fetch buddy
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (error) {
      debugPrint(error.toString());
    }
    return 'buddy';
  }

  // Example write to Firestore
  Future<void> editProfile(Student student) async {
    try {
      var ref = _firestore.collection('students').doc(student.id);
      await ref.set(student.toJson());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // Example read Firestore
  Future<Student?> getStudent(String id) async {
    try {
      var doc = await _firestore.collection('students').doc(id).get();
      if (doc.exists) {
        return Student.fromJson(doc.data()!);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }
}