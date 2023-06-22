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
  double? seat_height;
  bool? status;
  DateTime? registerDate;

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
      this.registerDate});
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
      'name': name,
      'last_name': last_name,
      'DNI': DNI,
      'age': age,
      'seat_height': seat_height,
      'weight': weight,
      'size': size,
      'waist': waist,
    };
  }
}
