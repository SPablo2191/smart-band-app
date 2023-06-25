import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/core/consts/api_route_map.dart';
import 'package:smartband/src/models/school_model.dart';

class SchoolProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['schools'] ?? '';

  Future<List<School>> getSchools() async {
    final url = Uri.parse('$_url$route');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final schools = Schools.fromJsonList(decodedData);
    return schools.items;
  }
}
