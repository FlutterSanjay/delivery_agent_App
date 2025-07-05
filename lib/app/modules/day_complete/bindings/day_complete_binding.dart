import 'package:get/get.dart';

import '../controllers/day_complete_controller.dart';

class DayCompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DayCompleteController>(
      () => DayCompleteController(),
    );
  }
}
