import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/models/school_model.dart';
import 'package:smartband/src/core/enums/api_route_enum.dart';

class SchoolProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = ApiRoute.schools.toString();

  Future<List<School>> getSchools() async {
    final url = Uri.https(_url, '/api/${route}');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Schools.fromJsonList(decodedData['results']);
    return movies.items;
  }
}
