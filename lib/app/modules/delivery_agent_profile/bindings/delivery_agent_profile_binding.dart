import 'package:get/get.dart';

import '../controllers/delivery_agent_profile_controller.dart';

class DeliveryAgentProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryAgentProfileController>(
      () => DeliveryAgentProfileController(),
    );
  }
}
