
class Student {
  int? id;
  // ignore: non_constant_identifier_names
  String? DNI;
  String? name;
  // ignore: non_constant_identifier_names
  String? last_name;
  String? password;
  String? email;
  List<dynamic>? schools;
  List<dynamic>? tests;
  bool? status;
  DateTime? registerDate;

  Student(
      {this.id,
      this.name,
      // ignore: non_constant_identifier_names
      this.last_name,
      // ignore: non_constant_identifier_names
      this.DNI,
      this.email,
      this.password,
      this.schools,
      this.status,
      this.registerDate,
      this.tests});
  Student.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    last_name = json['last_name'];
    DNI = json['DNI'];
    email = json['email'];
    password = json['password'];
    schools = json['schools'];
    status = json['status'];
    registerDate = json['registerDate'];
    tests = json['tests'];
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
