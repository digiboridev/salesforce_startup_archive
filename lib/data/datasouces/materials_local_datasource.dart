import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/materials/materials_catalog_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class MaterialsLocalDataSource {
  Future setMaterials(
      {required String customerSAP,
      required MaterialsCatalogModel materialsCatalogModel});

  Future<MaterialsCatalogModel> getMaterials({required String customerSAP});

  setMaterialsSyncTime(
      {required String customerSAP, required DateTime dateTime});

  Future<DateTime> getMaterialsSyncTime({required String customerSAP});
}

class MaterialsLocalDataSourceImpl implements MaterialsLocalDataSource {
  final materialsBox = GetStorage('materialsBox');
  final materialsSyncBox = GetStorage('materialsSyncBox');

  @override
  Future setMaterials(
      {required String customerSAP,
      required MaterialsCatalogModel materialsCatalogModel}) async {
    await materialsBox.write(customerSAP, materialsCatalogModel.toJson());
  }

  @override
  Future<MaterialsCatalogModel> getMaterials(
      {required String customerSAP}) async {
    String? data = materialsBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No cached materials for $customerSAP');
    }

    return MaterialsCatalogModel.fromJson(data);
  }

  @override
  Future setMaterialsSyncTime(
      {required String customerSAP, required DateTime dateTime}) async {
    await materialsSyncBox.write(customerSAP, dateTime.millisecondsSinceEpoch);
  }

  @override
  Future<DateTime> getMaterialsSyncTime({required String customerSAP}) async {
    int? data = materialsSyncBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No materials sync time for $customerSAP');
    }

    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
