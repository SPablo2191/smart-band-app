import 'package:smartband/src/models/school_model.dart';

class Teacher {
  int? id;
  String? DNI;
  String? name;
  String? last_name;
  String? password;
  String? email;
  List<School>? schools;
  bool? status;
  DateTime? registerDate;

  Teacher({
    required this.id,
    required this.name,
    required this.last_name,
    required this.DNI,
    required this.email,
    required this.password,
    required this.schools,
    required this.status,
    required this.registerDate,
  });
  Teacher.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    last_name = json['last_name'];
    DNI = json['DNI'];
    email = json['email'];
    password = json['password'];
    schools = json['schools'];
    status = json['status'];
    registerDate = json['registerDate'];
  }
}
