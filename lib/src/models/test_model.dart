// ignore_for_file: non_constant_identifier_names

import 'package:vital/src/models/promotion_model.dart';

class Test {
  int? id;
  int? status_test_id;
  int? promotion_id;
  int? teacher_id;
  bool? status;
  DateTime? registerDate;
  List<dynamic>? exercises;
  Promotion? promotion;
  
  Test(
      {this.id,
      this.status,
      this.promotion_id,
      this.status_test_id,
      this.teacher_id,
      this.registerDate,
      this.exercises,
      this.promotion});
  Test.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    promotion_id = json['promotion_id'];
    status_test_id = json['status_test_id'];
    teacher_id = json['teacher_id'];
    status = json['status'];
    registerDate = json['registerDate'];
    exercises = json['exercises'];
    promotion = Promotion.fromJsonMap(json['promotion']);
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
