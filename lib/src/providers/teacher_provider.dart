import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vital/src/core/consts/api_route_map.dart';
import 'package:vital/src/models/teacher_model.dart';

class TeacherProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['teachers'] ?? '';

  Future<Teacher> getTeacherById(int? id, String? accessToken) async {
    final url = Uri.parse('$_url$route/$id');
    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    final decodedData = json.decode(resp.body);
    final user = Teacher.fromJsonMap(decodedData);
    return user;
  }

  Future<bool> updateTeacher(Teacher teacher, String? accessToken) async {
    try {
      final url = Uri.parse('$_url$route/${teacher.id}');
      String body = jsonEncode(teacher.getMap());
      final resp = await http.put(
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
}
