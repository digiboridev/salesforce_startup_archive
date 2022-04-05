import 'package:***REMOVED***/data/datasouces/materials_remote_datasource.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/domain/usecases/get_materials_and_cache.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:get/get.dart';

class MaterialsCatalogController extends GetxController {
  CustomerController customerController = Get.find();
  GetMaterialsAndCache getMaterialsAndCache = Get.find();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  load() async {
    MaterialsCatalog catalog = await getMaterialsAndCache
        .call(customerController.selectedCustomerSAP!);
    print(catalog);
  }
}
