// ignore_for_file: non_constant_identifier_names

class StatusTest {
  int? id;
  String? description;
  bool? status;
  DateTime? registerDate;

  StatusTest({
    this.id,
    this.description,
    this.status,
    this.registerDate,
  });

  StatusTest.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    status = json['status'];
    registerDate = json['registerDate'];
  }
  Map<String, dynamic> getMap() {
    return {
      'description': description,
      'id': id,
    };
  }
}
