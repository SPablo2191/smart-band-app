import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/core/consts/api_route_map.dart';
import 'package:smartband/src/models/teacher_model.dart';

class TeacherProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['teachers'] ?? '';

  Future<Teacher> getTeacherById(int? id, String? accessToken) async {
    final url = Uri.parse('$_url$route/$id');
    print('url: $url');
    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    final decodedData = json.decode(resp.body);
    final user = Teacher.fromJsonMap(decodedData);
    print(user.name);
    return user;
  }
}
