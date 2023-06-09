import 'package:smartband/src/models/result_model.dart';

class Student {
  int? id;
  // ignore: non_constant_identifier_names
  String? DNI;
  String? name;
  // ignore: non_constant_identifier_names
  String? last_name;
  int? age;
  double? weight;
  double? size;
  // ignore: non_constant_identifier_names
  double? waist;
  // ignore: non_constant_identifier_names
  double? seat_height;
  bool? status;
  DateTime? registerDate;
  bool isSelected = false;
  Result? result;
  Student(
      {this.id,
      // ignore: non_constant_identifier_names
      this.DNI,
      this.name,
      // ignore: non_constant_identifier_names
      this.last_name,
      this.age,
      this.weight,
      this.size,
      this.waist,
      // ignore: non_constant_identifier_names
      this.seat_height,
      this.status,
      this.registerDate,
      this.result,
      this.isSelected = false});
  Student.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    DNI = json['DNI'];
    name = json['name'];
    last_name = json['last_name'];
    age = json['age'];
    seat_height = json['seat_height'];
    weight = json['weight'];
    size = json['size'];
    status = json['status'];
    waist = json['waist'];
    registerDate = json['registerDate'];
  }

  Map<String, dynamic> getMap() {
    return {
      'id': id,
      'name': name,
      'last_name': last_name,
      'DNI': DNI,
      'age': age,
      'seat_height': seat_height,
      'weight': weight,
      'size': size,
      'waist': waist,
      'result' : result?.getMap(),
    };
  }

  @override
  String toString() {
    return '${name!}${last_name!}'; // Mostrar el nombre de la escuela como representación en forma de texto
  }
}

class Students {
  List<Student> items = [];
  Students();
  Students.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    for (var element in jsonList) {
      final student = Student.fromJsonMap(element);
      items.add(student);
    }
  }
}
