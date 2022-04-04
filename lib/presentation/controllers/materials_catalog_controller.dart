import 'package:***REMOVED***/data/datasouces/materials_remote_datasource.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:get/get.dart';

class MaterialsCatalogController extends GetxController {
  CustomerController customerController = Get.find();
  @override
  void onReady() {
    super.onReady();

    MaterialsRemoteDatasource materialsRemoteDatasource =
        MaterialsRemoteDatasourceImpl();

    materialsRemoteDatasource.getCatalog(
        customerSAP: customerController.selectedCustomerSAP!);
  }
}
