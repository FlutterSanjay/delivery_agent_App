import 'package:get/get.dart';

import '../../../Services/record_sale_product_api.dart';
import '../controllers/record_sales_controller.dart';

class RecordSalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordSalesController>(() => RecordSalesController());
    Get.put<ApiProvider>(ApiProvider(), permanent: true);
  }
}
