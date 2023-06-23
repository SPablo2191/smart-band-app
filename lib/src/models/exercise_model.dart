// ignore_for_file: non_constant_identifier_names

class Exercise {
  int? id;
  String? description;
  bool? status;
  DateTime? registerDate;

  Exercise({
    this.id,
    this.description,
    this.status,
    this.registerDate,
  });


  Exercise.fromJsonMap(Map<String, dynamic> json) {
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

class Exercises {
  List<Exercise> items = [];
  Exercises();
  Exercises.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    for (var element in jsonList) {
      final school = Exercise.fromJsonMap(element);
      items.add(school);
    }
  }
}
