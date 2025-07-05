import 'package:get/get.dart';

class StoreAssignController extends GetxController {
  //TODO: Implement StoreAssignController
  var currentIndex = 0.obs;

  RxString selectedValue = 'Distance'.obs;
  RxList<String> statusItem = ['All', 'Yet To Deliver', 'Delivered', 'No Order'].obs;
  RxBool isSelect = true.obs;
  final count = 0.obs;

  var selectedItem = (-1).obs; // -1 means nothing selected

  void selectItem(int index) {
    selectedItem.value = index;
  }

  // Bottom Bar Navigation
  void changePage(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
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
