import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vital/src/core/consts/api_route_map.dart';
import 'package:vital/src/models/student_model.dart';

class StudentProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['students'] ?? '';

  Future<bool> createStudent(Student newStudent, String? accessToken) async {
    try {
      final url = Uri.parse('$_url$route');
      String body = jsonEncode(newStudent.getMap());
      final resp = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      if (resp.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Student>> getStudents(String? accessToken) async {
    try {
      final url = Uri.parse('$_url$route');
      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (resp.statusCode == 200) {
        final decodedData = json.decode(resp.body);
        final students = Students.fromJsonList(decodedData);
        return students.items;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
