import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/UrlPath/UrlPath.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class PaymentServices {
  final storage = StorageService();

  final uri = UrlPath.MAIN_URL;

  Future<Map<String, dynamic>> createPayment({
    required int amount,
    required String storeName,
  }) async {
    final resp = await http.post(
      Uri.parse('${uri}create-payment-link'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"amount": amount, "storeName": storeName}),
    );

    if (resp.statusCode == 200) {
      print("Payemnt Data: ${resp.body}");
      return jsonDecode(resp.body);
    } else {
      print(resp.body);
      throw Exception('Failed to create payment link: ${resp.body}');
    }
  }

  Future<Map<String, dynamic>> getPaymentStatus(String orderId) async {
    final resp = await http.get(Uri.parse('${uri}payment-status/$orderId'));

    if (resp.statusCode == 200) {
      print("getPaymentStatus Data: ${resp.body}");
      return jsonDecode(resp.body);
    } else if (resp.statusCode == 202) {
      return jsonDecode(resp.body);
    } else {
      throw Exception('Failed to fetch payment status');
    }
  }

  Future<void> sendInvoiceToBackend(File file, String recipientEmail) async {
    const username = 'airforceschoolsanjay@gmail.com';
    const password = 'vxys xrtu xxzq fgeb'; // Not your normal Gmail password!

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your Flutter App')
      ..recipients.add(recipientEmail)
      ..subject = 'Invoice from Flutter App'
      ..text = 'Hi, please find your invoice attached below.'
      ..attachments = [FileAttachment(file)];

    try {
      final sendReport = await send(message, smtpServer);
      print('✅ Email sent: ${sendReport.toString()}');
    } on MailerException catch (e) {
      print('❌ Message not sent. ${e.toString()}');
    }
  }
}
