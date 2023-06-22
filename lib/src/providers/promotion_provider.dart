// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartband/src/core/consts/api_route_map.dart';
import 'package:smartband/src/models/promotion_model.dart';
import 'package:smartband/src/models/student_model.dart';

class PromotionProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['promotions'] ?? '';

  Future<bool> createPromotion(
      Promotion newPromotion, String? accessToken) async {
    try {
      final url = Uri.parse('$_url$route/${newPromotion.school_id}');
      print(url);
      print(accessToken);
      String body = jsonEncode(newPromotion.getMap());
      print(body);
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
      print(e);
      return false;
    }
  }

  Future<List<Promotion>> getPromotions(
      int? school_id, String? accessToken) async {
    try {
      final url = Uri.parse('$_url$route/$school_id');
      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      final decodedData = json.decode(resp.body);
      print(decodedData);
      final promotions = Promotions.fromJsonList(decodedData);
      return promotions.items;
    } catch (e) {
      print('holaaa $e');
      return [];
    }
  }
}
