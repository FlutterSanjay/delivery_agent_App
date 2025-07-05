import 'package:get/get.dart';

import '../controllers/store_assign_controller.dart';

class StoreAssignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreAssignController>(
      () => StoreAssignController(),
    );
  }
}
