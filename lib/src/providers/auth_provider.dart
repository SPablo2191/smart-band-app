import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/core/consts/api_route_map.dart';
import 'package:smartband/src/models/teacher_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';

  Future<Teacher> register(Teacher teacher) async {
    try {
      final endpoint = getApiRoutes()['register'];
      final url = Uri.parse('$_url$endpoint');
      String body = jsonEncode(teacher.getMap());
      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);
      final decodedData = json.decode(resp.body);
      final response = Teacher.fromJsonMap(decodedData);
      return response;
    } catch (e) {
      // Hubo un error al realizar la solicitud HTTP
      return Teacher();
    }
  }

Future<bool> login(String? email, String? password) async {
  try {
    final endpoint = getApiRoutes()['login'];
    final url = Uri.parse('$_url$endpoint');
    Map<String, String> body = {'email': email ?? '', 'password': password ?? ''};
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    
    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', decodedData['access_token']);
      return true;
    } else {
      print('Error: ${resp.statusCode}');
      return false;
    }
  } catch (e) {
    // Hubo un error al realizar la solicitud HTTP
    print('Exception: $e');
    return false;
  }
}
}
