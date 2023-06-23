// ignore_for_file: non_constant_identifier_names

class Test {
  int? id;
  int? status_test_id;
  int? promotion_id;
  int? teacher_id;
  bool? status;
  DateTime? registerDate;

  Test(
      {this.id,
      this.status,
      this.promotion_id,
      this.status_test_id,
      this.teacher_id,
      this.registerDate});
  Test.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    promotion_id = json['promotion_id'];
    status_test_id = json['status_test_id'];
    teacher_id = json['teacher_id'];
    status = json['status'];
    registerDate = json['registerDate'];
  }

  Map<String, dynamic> getMap() {
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
