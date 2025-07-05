import 'package:get/get.dart';

import '../controllers/end_of_day_controller.dart';

class EndOfDayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EndOfDayController>(
      () => EndOfDayController(),
    );
  }
}
