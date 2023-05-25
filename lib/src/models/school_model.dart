class School {
  int? id;
  String? name;
  bool? status;
  DateTime? registerDate;

  School({
    required this.id,
    required this.name,
    required this.status,
    required this.registerDate,
  });
  School.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    registerDate = json['registerDate'];
  }
}
