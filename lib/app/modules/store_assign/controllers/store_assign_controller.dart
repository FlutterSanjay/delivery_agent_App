import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/Services/storeAssign/order_summary_service.dart';
import 'package:delivery_agent/app/data/model/order_model.dart';
import 'package:get/get.dart';

import '../../../Services/storeAssign/storeService.dart';
import '../../../auth/agent_location_updater.dart';
import '../../../auth/geo_location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/storeAssign/order_item_summary_model.dart';

class StoreAssignController extends GetxController {
  final storage = StorageService();
  final StoreService storeService = StoreService();
  final LocationService locationService = LocationService();
  final LocationUploader locationUploader = LocationUploader();
  final OrderSummaryService orderSummaryService = OrderSummaryService();

  // RxList<Map<String, dynamic>> allOrders =
  //     <Map<String, dynamic>>[].obs; // saare orders
  // RxList<Map<String, dynamic>> filteredOrders = <Map<String, dynamic>>[].obs;

  // Future<Map<String, dynamic>> _fetchOrders() async {
  //   try {
  //     loading.value = true;
  //     allOrders.clear();
  //     // orders.clear();
  //     filteredOrders.clear();

  //     final Map<String, dynamic> response = await storeService.getStoreById(
  //       vehicleId: '31ebd0f7-40c6-4e42-9117-bb8daa1e60e7',
  //       dataType: "Orders",
  //     );
  //   } catch (e) {
  //     Get.snackbar("Error", "Something Went Wrong!");
  //     print("Error:$e");
  //   }
  // }

  var currentIndex = 0.obs;
  RxString selectedValue = 'Distance'.obs;
  RxList<String> statusItem = ['All', 'Yet To Deliver', 'Delivered'].obs;

  RxBool isSelect = true.obs;
  final count = 0.obs;
  var loading = false.obs;

  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  /// Yeh list store aur orders dono rakhegi
  var combinedList = <Map<String, dynamic>>[].obs;

  /// Sirf orders
  // var orders = <Map<String, dynamic>>[].obs;

  /// Sirf stores
  var stores = <Map<String, dynamic>>[].obs;

  var selectedItem = (-1).obs;

  void selectItem(int index) {
    selectedItem.value = index;
  }

  void changePage(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    // fetchOrderItems();
    super.onInit();
    _getAllStores();
    final agentId = storage.getUserId() ?? " ";
    _startListening(agentId);
  }

  /// ✅ API call -> stores + orders fetch
  void _getAllStores() async {
    try {
      loading.value = true;
      combinedList.clear();
      // orders.clear();
      stores.clear();

      final Map<String, dynamic> response = await storeService.getStoreById(
        vehicleId: '31ebd0f7-40c6-4e42-9117-bb8daa1e60e7',
        dataType: "Stores",
      );

      // final tempList = <Map<String, dynamic>>[];

      // ✅ Orders ko alag rakho
      // for (var order in response['orders']) {
      //   final formatted = {"type": "order", "data": order};
      //   orders.add(formatted);
      //   tempList.add(formatted);
      // }

      // ✅ Stores ko alag rakho
      for (var store in response['stores']) {
        final formatted = {"type": "store", "data": store};
        stores.add(formatted);
        // tempList.add(formatted);
      }

      // combinedList.assignAll(tempList);

      // print("✅ Orders Loaded: ${orders.length}");
      print("✅ Stores Loaded: ${stores.length}");
    } catch (e) {
      Get.snackbar("Error", "Something Went Wrong: $e");
    } finally {
      loading.value = false;
    }
  }

  /// ✅ Sirf ek store ke saare orders laane ke liye
  // List<Map<String, dynamic>> getOrdersByStoreId(String storeId) {
  //   try {
  //     return orders
  //         .where(
  //           (order) =>
  //               order["type"] == "order" &&
  //               order["data"]["storeId"].toString() == storeId,
  //         )
  //         .map((order) => order["data"] as Map<String, dynamic>)
  //         .toList();
  //   } catch (e) {
  //     print("⚠️ Error filtering orders: $e");
  //     return [];
  //   }
  // }

  /// ✅ Location listener
  void _startListening(String agentId) async {
    try {
      final isReady = await locationService.ensurePermissions();
      if (!isReady) {
        print("❌ Location service not enabled or permission denied");
        return;
      }

      final locationStream = await locationService.getLocationStream();
      if (locationStream == null) {
        print("❌ Location stream not available");
        return;
      }

      locationStream.listen(
        (locationData) {
          locationUploader.sendLocationToBackend(
            agentId,
            locationData.latitude,
            locationData.longitude,
          );
          storage.saveAgentLatitude("${locationData.latitude}");
          storage.saveAgentLongitude("${locationData.longitude}");
        },
        onError: (error) {
          print("⚠️ Location stream error: $error");
        },
      );
    } catch (e) {
      print("🔥 Error initializing location listener: $e");
    }
  }

  // For Calling
  Future<void> makePhoneCall(String phoneNumber) async {
    // Clean number: remove spaces, dashes, brackets, etc.
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    final Uri url = Uri(scheme: 'tel', path: cleanedNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // will open dialer
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  // Store Location pasing to Map
  // Map<String, double> storeLocation(double lat, double long) {
  //   return {'lat': lat, 'long': long};
  // }

  void increment() => count.value++;

  // Order Summary One Store Part
  var items = <Order>[].obs;

  /// Subtotal nikalo saare orders ke andar ke products ka
  double get subtotal {
    double total = 0;
    for (var order in items) {
      for (var product in order.products ?? []) {
        total += (product.price ?? 0) * (product.quantity ?? 0);
      }
    }
    return total;
  }

  /// 10% discount
  double get tax {
    if (subtotal == 0) return 0;
    return subtotal * 0.10; // 10% discount
  }

  /// Final total after discount
  double get total => subtotal + tax;

  /// API se ek order fetch karna aur list me dalna
  void fetchOrderItems(String orderId) async {
    final data = await orderSummaryService.getOrderItems(orderId);

    items.assignAll(data); // ✅ ab Order list assign hoga
  }
}
