// ignore_for_file: non_constant_identifier_names

import 'class_model.dart';

class Promotion {
  int? id;
  DateTime? promotion_year;
  int? class_id;
  int? school_id;
  bool? status;
  DateTime? registerDate;
  Class? classroom;

  Promotion(
      {this.id,
      this.class_id,
      this.school_id,
      this.promotion_year,
      this.status,
      this.registerDate,
      this.classroom});

  Promotion.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    class_id = json['class_id'];
    school_id = json['school_id'];
    promotion_year = DateTime.parse(json['promotion_year']);
    status = json['status'];
    registerDate = json['registerDate'];
    classroom = Class.fromJsonMap(json['prom_class']);
  }
  Map<String, dynamic> getMap() {
    return {
      'promotion_year': promotion_year?.toIso8601String(),
      'id': id,
      'class_id': class_id,
      'school_id': school_id,
    };
  }
}

class Promotions {
  List<Promotion> items = [];
  Promotions();
  Promotions.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    for (var element in jsonList) {
      final promotion = Promotion.fromJsonMap(element);
      items.add(promotion);
    }
  }
}
