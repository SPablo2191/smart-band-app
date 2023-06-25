// ignore_for_file: non_constant_identifier_names

import 'package:vital/src/models/promotion_model.dart';
import 'package:vital/src/models/status_test_model.dart';
import 'package:intl/intl.dart';

class Test {
  int? id;
  int? status_test_id;
  int? promotion_id;
  int? teacher_id;
  bool? status;
  DateTime? registerDate;
  List<dynamic>? exercises;
  Promotion? promotion;
  StatusTest? statusTest;
  Test({
    this.id,
    this.status,
    this.promotion_id,
    this.status_test_id,
    this.teacher_id,
    this.registerDate,
    this.exercises,
    this.promotion,
    this.statusTest,
  });
  Test.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    promotion_id = json['promotion_id'];
    status_test_id = json['status_test_id'];
    teacher_id = json['teacher_id'];
    status = json['status'];
    registerDate = DateTime.parse(json['register_date']);
    exercises = json['exercises'];
    promotion = Promotion.fromJsonMap(json['promotion']);
    statusTest = StatusTest.fromJsonMap(json['status_test']);
  }
  getRegisterDate() {
    return DateFormat('dd/MM/yyyy').format(registerDate ?? DateTime.now());
  }

  Map<String, dynamic> getMap() {
    List<Map<String, dynamic>> auxExercises = [];
    for (var exercise in exercises!) {
      auxExercises.add(exercise.getMap());
    }
    return {
      'promotion_id': promotion_id,
      'status_test_id': status_test_id,
      'teacher_id': teacher_id,
      'exercises': auxExercises,
    };
  }
  Map<String, dynamic> getMap2() {

    return {
      'promotion_id': promotion_id,
      'status_test_id': status_test_id,
      'teacher_id': teacher_id,
    };
  }
}

class Tests {
  List<Test> items = [];
  Tests();
  Tests.fromJsonList(List<dynamic> jsonList) {
    for (var element in jsonList) {
      final test = Test.fromJsonMap(element);
      items.add(test);
    }
  }
}
