import 'package:get/get.dart';

import '../controllers/map_interation_controller.dart';

class MapInterationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapInterationController()); // Inject controller once
  }
}
