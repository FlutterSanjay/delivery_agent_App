import 'dart:async';
import 'dart:io';
import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/Services/storeAssign/storeService.dart';
import 'package:delivery_agent/app/modules/payment_page/Repository/payment_services.dart';
import 'package:delivery_agent/app/modules/payment_page/views/payment_success_dialog.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class PaymentPageController extends GetxController {
  var upiLink = ''.obs;
  var orderId = ''.obs;
  var paid = false.obs;
  var loading = false.obs;

  final PaymentServices _paymentService = PaymentServices();
  final StoreService _storeService = StoreService();
  Timer? _pollTimer;

  final storage = StorageService();

  final args = Get.arguments;

  String get subtotal => args["subtotal"]?.toString() ?? "0.0";
  String get tax => args["tax"] ?? "0.0";
  String get total => args["total"]?.toString() ?? "0.0";
  String get storeName => args["storeName"]?.toString() ?? "Demo Store";
  String get storeId => args["storeId"]?.toString() ?? "Unkown Id";
  String get productQuantity => args["productQuantity"]?.toString() ?? "1";

  // Generate the Invoice
  // file: invoice_generator.dart

  var items = [
    {"name": "Wireless Mouse", "qty": 1, "price": 499.0},
    {"name": "Laptop Bag", "qty": 1, "price": 899.0},
  ].obs;

  /// 👉 Function to generate and save PDF
  Future<File> generateInvoice() async {
    final pdf = pw.Document();

    // Total calculate
    double total = items.fold(
      0,
      (sum, item) => sum + (item['price'] as double) * (item['qty'] as int),
    );

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Sales Yatra Pvt. Ltd.",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text("2nd Floor, Tech Park, Bangalore\nPhone: +91 98765 43210"),
            pw.SizedBox(height: 20),
            pw.Text(
              "Invoice: ${orderId.value}",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text("Customer: $storeName"),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ["Item", "Qty", "Price", "Total"],
              data: items.map((e) {
                double itemTotal = (e['qty'] as int) * (e['price'] as double);
                return [
                  e['name'].toString(),
                  e['qty'].toString(),
                  "Rs.${e['price']}",
                  "Rs.${itemTotal.toStringAsFixed(2)}",
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                "Grand Total: Rs${total.toStringAsFixed(2)}",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 40),
            pw.Text(
              "Thank you for shopping with us!",
              style: pw.TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );

    // Save file to local directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/invoice_${orderId.value}.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  Future<void> createAndSendInvoice() async {
    final file = await generateInvoice();

    await _paymentService.sendInvoiceToBackend(
      file,
      '${storage.getStoreEmail()}',
    );
  }

  void checkStatus() async {
    if (orderId.value.isEmpty) return;
    print("Order Id:${orderId.value}");
    try {
      final response = await _paymentService.getPaymentStatus(orderId.value);
      print("CheckStatus:${response}");
      if (response['paid'] == true && !paid.value) {
        paid.value = true;
        await storage.savePaid(true);
        _pollTimer?.cancel();

        print("Get Order Id :${storage.getOrderId()}");

        // Update order status in backend
        await _storeService.updateOrderStatus(
          orderId: "${storage.getOrderId()}",
          status: "delivered",
        );
        Get.dialog(
          PaymentSuccessDialog(
            transactionId: response['id'],
            amount: total,
            controller: PaymentPageController(),
          ),
          barrierDismissible: false, // dialog tap karke band na ho
        );
      } else {
        print(response);
      }
    } catch (e) {
      print('Error polling status: $e');
    }
  }

  void createPayment({
    required double
    amount, // amount in rupees as double from double.parse(total)
    required String storeName,
  }) async {
    loading.value = true;
    upiLink.value = '';
    orderId.value = '';
    paid.value = false;

    try {
      final response = await _paymentService.createPayment(
        amount: (amount * 100).round(), // Convert rupees to paise
        storeName: storeName,
      );

      upiLink.value = response['url'];
      orderId.value = response['sessionId'];

      // Start polling
      _pollTimer?.cancel();
      _pollTimer = Timer.periodic(Duration(seconds: 3), (_) => checkStatus());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    _pollTimer?.cancel();
    super.onClose();
  }

  // UPI Payment Link (for QR)
  late String upiPaymentLink;

  // UI state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    // String merchantUpi = "8013812268@ybl"; // demo UPI ID
    // upiPaymentLink = "upi://pay?pa=$merchantUpi&pn=$storeName&am=$total&cu=INR";
    createPayment(amount: double.parse(total), storeName: storeName);
  }

  @override
  void onReady() {
    super.onReady();
    isLoading.value = false;
  }
}
