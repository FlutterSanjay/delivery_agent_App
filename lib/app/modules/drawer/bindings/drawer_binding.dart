import 'package:get/get.dart';

import '../controllers/drawer_controller.dart';

class DrawerBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawerBarController>(() => DrawerBarController());
  }
}
