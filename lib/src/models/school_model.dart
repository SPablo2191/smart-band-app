class School {
  int? id;
  String? name;
  bool? status;
  DateTime? registerDate;

  School({
    this.id,
    this.name,
    this.status,
    this.registerDate,
  });
  School.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    registerDate = json['registerDate'];
  }
}

class Schools {
  List<School> items = [];
  Schools();
  Schools.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    for (var element in jsonList) {
      final school = School.fromJsonMap(element);
      items.add(school);
    }
  }
}
