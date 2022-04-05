import 'package:***REMOVED***/data/datasouces/materials_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/materials_remote_datasource.dart';
import 'package:***REMOVED***/data/models/materials/materials_catalog_model.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';

abstract class MaterialsRepository {
  Future<MaterialsCatalog> getRemoteCatalog({required String customerSAP});
  Future<MaterialsCatalog> getLocalMaterials({required String customerSAP});
  Future setLocalMaterials(
      {required String customerSAP,
      required MaterialsCatalog materialsCatalog});
  Future<DateTime> getMaterialsSyncTime({required String customerSAP});
  Future setMaterialsSyncTime(
      {required String customerSAP, required DateTime dateTime});
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
  Future<DateTime> getMaterialsSyncTime({required String customerSAP}) =>
      materialsLocalDataSource.getMaterialsSyncTime(customerSAP: customerSAP);

  @override
  Future setMaterialsSyncTime(
          {required String customerSAP, required DateTime dateTime}) =>
      materialsLocalDataSource.setMaterialsSyncTime(
          customerSAP: customerSAP, dateTime: dateTime);
}
