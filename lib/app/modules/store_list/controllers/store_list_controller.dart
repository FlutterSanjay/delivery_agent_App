import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/Services/storeList/storeList.dart';
import 'package:get/get.dart';

import '../../store_assign/views/store_assign_view.dart';

class StoreListController extends GetxController {
  final storage = StorageService();
  final StoreList storeListService = StoreList();
  RxBool isLoading = true.obs;
  RxString userName = ''.obs;
  RxString totalSalePrice = ''.obs;
  RxString licensePlate = ''.obs;
  RxString routeName = ''.obs;
  RxString totalStoreAssign = ''.obs;

  // Fetch data based on api

  //TODO: Implement StoreListController
  RxBool isCheck = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    fetchUserName();
    super.onInit();
  }

  void fetchUserName() async {
    try {
      final data = await storeListService.getName();
      if (data != null) {
        userName.value = data['name'];
        storage.saveWarehouseId(data['warehouseId']);

        final deliveryAgentData = await storeListService
            .getDeliveryAgentDetail();

        if (deliveryAgentData['message'] != "User Not Found") {
          totalSalePrice.value = '80';

          print(deliveryAgentData['agent']['status']);
          final vehicleData = deliveryAgentData['vehicle'];
          final deliveryProfile = deliveryAgentData['profile'];
          licensePlate.value = vehicleData['licensePlate'];
          routeName.value =
              "${vehicleData['route']['street']} ${vehicleData['route']['city']}" ??
              'unknown';

          storage.saveVehicleId("${vehicleData['licensePlate']}");

          storage.saveAgentTown("${vehicleData['route']['city']}");

          totalStoreAssign.value = "${deliveryProfile['totalDeliveries']}";

          storage.saveTotalDelivery("${deliveryProfile['totalDeliveries']}");

          isLoading.value = false;
        } else {
          Get.snackbar("Error", "Something Went Wrong!");
          return;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Something Went Wrong');
    }
  }

  void checkAgreement() {
    if (isCheck.value) {
      Get.offAll(
        () => StoreAssignView(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 500),
      );
      return;
    }
    Get.snackbar("Alert!", "Please check the agree box to continue.");
    return;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
