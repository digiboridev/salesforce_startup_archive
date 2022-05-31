import 'package:***REMOVED***/data/datasouces/materials_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/materials_remote_datasource.dart';
import 'package:***REMOVED***/data/models/materials/materials_catalog_model.dart';
import 'package:***REMOVED***/data/models/sync_data.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';

abstract class MaterialsRepository {
  Future<MaterialsCatalog> getRemoteCatalog({required String customerSAP});
  Future<MaterialsCatalog> getLocalMaterials({required String customerSAP});
  Future setLocalMaterials(
      {required String customerSAP,
      required MaterialsCatalog materialsCatalog});
  Future<SyncData> getMaterialsSyncData({required String customerSAP});
  Future setMaterialsSyncData(
      {required String customerSAP, required SyncData syncData});

  Future subscribeToMaterial(
      {required String customerSAP, required String materialNumber});
}

class MaterialsRepositoryImpl implements MaterialsRepository {
  final MaterialsLocalDataSource materialsLocalDataSource;
  final MaterialsRemoteDatasource materialsRemoteDatasource;
  MaterialsRepositoryImpl({
    required this.materialsLocalDataSource,
    required this.materialsRemoteDatasource,
  });

  @override
  Future<MaterialsCatalog> getRemoteCatalog({required String customerSAP}) =>
      materialsRemoteDatasource.getCatalog(customerSAP: customerSAP);

  @override
  Future<MaterialsCatalog> getLocalMaterials({required String customerSAP}) =>
      materialsLocalDataSource.getMaterials(customerSAP: customerSAP);

  @override
  Future setLocalMaterials(
          {required String customerSAP,
          required MaterialsCatalog materialsCatalog}) =>
      materialsLocalDataSource.setMaterials(
          customerSAP: customerSAP,
          materialsCatalogModel:
              MaterialsCatalogModel.fromEntity(materialsCatalog));

  @override
  Future<SyncData> getMaterialsSyncData({required String customerSAP}) =>
      materialsLocalDataSource.getMaterialsSyncData(customerSAP: customerSAP);

  @override
  Future setMaterialsSyncData(
          {required String customerSAP, required SyncData syncData}) =>
      materialsLocalDataSource.setMaterialsSyncData(
          customerSAP: customerSAP, syncData: syncData);

  Future subscribeToMaterial(
          {required String customerSAP, required String materialNumber}) =>
      materialsRemoteDatasource.subscribeToMaterial(
          customerSAP: customerSAP, materialNumber: materialNumber);
}
