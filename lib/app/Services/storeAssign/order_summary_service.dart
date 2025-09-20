import 'dart:convert';
import 'package:delivery_agent/app/UrlPath/UrlPath.dart';
import 'package:delivery_agent/app/data/model/storeAssign/order_item_summary_model.dart';
import 'package:http/http.dart' as http;

class OrderSummaryService {
  static final String baseUrl = UrlPath.MAIN_URL;

  Future<List<Order>> getOrderItems(String orderId) async {
    final url = Uri.parse("$baseUrl/store/orders/$orderId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // JSON ko OrderResponse me convert karenge
        final orderResponse = OrderResponse.fromJson(data);

        // Agar orders mile toh return karo
        if (orderResponse.orders != null && orderResponse.orders!.isNotEmpty) {
          return orderResponse.orders!;
        }
      } else {
        print("❌ Error: ${response.statusCode}");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
    }

    return [];
  }
}
