import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/core/consts/api_route_map.dart';
import 'package:smartband/src/models/teacher_model.dart';

class RegisterProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['register'] ?? '';

  Future<Teacher> register(Teacher teacher) async {
    String teacherJson = json.encode(teacher);
    try {
      final url = Uri.https(_url, route);
      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: teacherJson);
      final decodedData = json.decode(resp.body);
      final response = Teacher.fromJsonMap(decodedData);
      return response;
    } catch (e) {
      // Hubo un error al realizar la solicitud HTTP
      return Teacher();
    }
  }
}
