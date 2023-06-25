import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/core/consts/api_route_map.dart';
import 'package:smartband/src/models/class_model.dart';

class ClassProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['classes'] ?? '';

  getClasses(String? accessToken) async {
    final url = Uri.parse('$_url$route');
    final resp = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },);
    final decodedData = json.decode(resp.body);
    final classes = Classes.fromJsonList(decodedData);
    return classes.items;
  }
}
