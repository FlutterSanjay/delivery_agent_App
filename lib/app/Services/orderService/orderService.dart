import 'dart:convert';
import 'package:delivery_agent/app/UrlPath/UrlPath.dart';
import 'package:delivery_agent/app/data/model/orderModel/inventory_order_model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String uri = UrlPath.MAIN_URL;

  Future<List<InventoryOrderModel>> fetchInventoryProducts(
    String vehicleId,
  ) async {
    try {
      var response = await http.get(
        Uri.parse('${uri}products/vehicle/$vehicleId'),
      );
      if (response.statusCode == 200) {
        // Assuming the response body is a JSON array of products
        var data = jsonDecode(response.body);

        final List products = data['data'];

        return products
            .map((product) => InventoryOrderModel.fromJson(product))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
