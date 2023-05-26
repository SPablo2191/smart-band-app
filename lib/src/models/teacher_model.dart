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
    this.id,
    this.name,
    this.last_name,
    this.DNI,
    this.email,
    this.password,
    this.schools,
    this.status,
    this.registerDate,
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
  isValid() {
    return !(name == null &&
        last_name == null &&
        DNI == null &&
        email == null &&
        password == null &&
        schools == null);
  }

  Map<String, dynamic> getMap() {
    List<Map<String, dynamic>> auxSchools = [];
    for (var school in schools!) {
      auxSchools.add(school.getMap());
    }
    return {
      'name': name,
      'last_name': last_name,
      'DNI': DNI,
      'email': email,
      'password': password,
      'schools': auxSchools,
    };
  }
}
