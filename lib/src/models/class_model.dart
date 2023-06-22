// ignore_for_file: non_constant_identifier_names

class Class {
  int? id;
  int? school_id;
  String? name;
  bool? status;
  DateTime? registerDate;

  Class({
    this.id,
    this.name,
    this.status,
    this.school_id,
    this.registerDate,
  });
  @override
  String toString() {
    return name ??
        ''; // Mostrar el nombre de la escuela como representación en forma de texto
  }

  Class.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    school_id = json['school_id'];
    name = json['name'];
    status = json['status'];
    registerDate = json['registerDate'];
  }
  Map<String, dynamic> getMap() {
    return {
      'name': name,
      'id': id,
      'school_id': school_id,
    };
  }
}

class Classes {
  List<Class> items = [];
  Classes();
  Classes.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    for (var element in jsonList) {
      final school = Class.fromJsonMap(element);
      items.add(school);
    }
  }
}
