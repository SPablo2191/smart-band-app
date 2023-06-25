// ignore_for_file: non_constant_identifier_names

class Result {
  int? id;
  int? number_steps;
  String? calories;
  double? average_heart_rate;
  String? average_rate;
  double? average_speed;
  double? distance;
  double? average_cadene;
  double? average_stride;
  double? result;
  String? device_name;
  int? exercise_test_id;
  int? student_id;
  bool? status;
  DateTime? registerDate;

  Result(
      {this.id,
      this.number_steps,
      this.calories,
      this.average_heart_rate,
      this.average_rate,
      this.average_speed,
      this.average_cadene,
      this.average_stride,
      this.result,
      this.device_name,
      this.distance,
      this.exercise_test_id,
      this.student_id,
      this.status,
      this.registerDate});
  Result.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    number_steps = json['number_steps'];
    calories = json['calories'];
    average_heart_rate = json['average_heart_rate'];
    average_rate = json['average_rate'];
    average_speed = json['average_speed'];
    average_cadene = json['average_cadene'];
    average_stride = json['average_stride'];
    result = json['result'];
    device_name = json['device_name'];
    distance = json['distance'];
    exercise_test_id = json['exercise_test_id'];
    student_id = json['student_id'];
    status = json['status'];
    registerDate = json['registerDate'];
  }

  Map<String, dynamic> getMap() {
    return {
      'id': id,
      'number_steps': number_steps,
      'calories': calories,
      'average_heart_rate': average_heart_rate,
      'average_rate': average_rate,
      'average_speed': average_speed,
      'average_cadene': average_cadene,
      'average_stride': average_stride,
      'result': result,
      'device_name': device_name,
      'exercise_test_id': exercise_test_id,
      'student_id': student_id,
      'distance': distance,
    };
  }
}

class Results {
  List<Result> items = [];
  Results();
  Results.fromJsonList(List<dynamic> jsonList) {
    for (var element in jsonList) {
      final item = Result.fromJsonMap(element);
      items.add(item);
    }
  }
}
