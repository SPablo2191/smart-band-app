import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/core/consts/api_route_map.dart';


import '../models/exercise_model.dart';

class ExerciseProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['exercises'] ?? '';

  Future<List<Exercise>> getExercises(String? accessToken) async {
    final url = Uri.parse('$_url$route');
    final resp = await http.get(url,headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },);
    final decodedData = json.decode(resp.body);
    final exercises = Exercises.fromJsonList(decodedData);
    return exercises.items;
  }
}
