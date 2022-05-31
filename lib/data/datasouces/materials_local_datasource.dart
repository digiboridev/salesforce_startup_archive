import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/materials/materials_catalog_model.dart';
import 'package:***REMOVED***/data/models/sync_data.dart';
import 'package:get_storage/get_storage.dart';

abstract class MaterialsLocalDataSource {
  Future setMaterials(
      {required String customerSAP,
      required MaterialsCatalogModel materialsCatalogModel});

  Future<MaterialsCatalogModel> getMaterials({required String customerSAP});

  Future setMaterialsSyncData(
      {required String customerSAP, required SyncData syncData});

  Future<SyncData> getMaterialsSyncData({required String customerSAP});
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
  Future setMaterialsSyncData(
      {required String customerSAP, required SyncData syncData}) async {
    await materialsSyncBox.write(customerSAP, syncData.toJson());
  }

  @override
  Future<SyncData> getMaterialsSyncData({required String customerSAP}) async {
    String? data = materialsSyncBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No materials sync time for $customerSAP');
    }

    return SyncData.fromJson(data);
  }
}
