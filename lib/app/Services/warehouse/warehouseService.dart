import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../UrlPath/UrlPath.dart';
import '../../data/model/warehouseModel/warehouseModel.dart';

class WarehouseService {
  static final String baseUrl = "${UrlPath.MAIN_URL}/allWarehouse";

  static Future<List<Warehouse>> fetchWarehouses() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // ✅ Assuming response is a List of warehouses
        if (data is List) {
          return data.map<Warehouse>((w) => Warehouse.fromMap(w)).toList();
        } else {
          throw Exception("Invalid response format: Expected List");
        }
      } else {
        throw Exception("Failed to load warehouses: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load warehouses: $e");
    }
  }
}
