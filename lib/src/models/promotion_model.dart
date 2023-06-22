// ignore_for_file: non_constant_identifier_names

class Promotion {
  int? id;
  DateTime? promotion_year;
  int? class_id;
  int? school_id;
  bool? status;
  DateTime? registerDate;

  Promotion({
    this.id,
    this.class_id,
    this.school_id,
    this.promotion_year,
    this.status,
    this.registerDate,
  });

  Promotion.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    class_id = json['class_id'];
    school_id = json['school_id'];
    promotion_year = json['promotion_year'];
    status = json['status'];
    registerDate = json['registerDate'];
  }
  Map<String, dynamic> getMap() {
    return {
      'promotion_year': promotion_year.toString(),
      'id': id,
      'class_id': class_id,
      'school_id': school_id,
    };
  }
}
