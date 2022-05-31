import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/sync_data.dart';
import 'package:***REMOVED***/data/repositories/materials_repository.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetMaterialsAndCache
    implements UseCase<MaterialsCatalog, GetMaterialsAndCacheParams> {
  final MaterialsRepository materialsRepository;

  GetMaterialsAndCache(this.materialsRepository);

  @override
  Future<MaterialsCatalog> call(GetMaterialsAndCacheParams params) async {
    try {
      MaterialsCatalog cachedMaterialsCatalog =
          await _loadCache(params: params);
      return cachedMaterialsCatalog;
    } catch (e) {
      if (!params.hasConnection) {
        throw InternalException('No connection');
      }
      MaterialsCatalog remoteMaterialsCatalog = await materialsRepository
          .getRemoteCatalog(customerSAP: params.customerSAP);

      materialsRepository.setLocalMaterials(
          customerSAP: params.customerSAP,
          materialsCatalog: remoteMaterialsCatalog);

      materialsRepository.setMaterialsSyncData(
          customerSAP: params.customerSAP,
          syncData:
              SyncData(syncDateTime: DateTime.now(), locale: params.locale));
      return remoteMaterialsCatalog;
    }
  }

  Future<MaterialsCatalog> _loadCache(
      {required GetMaterialsAndCacheParams params}) async {
    if (await _cacheValid(params: params)) {
      return materialsRepository.getLocalMaterials(
          customerSAP: params.customerSAP);
    } else {
      throw InternalException(
          'Unable to load catalog for consumer ${params.customerSAP}');
    }
  }

  Future<bool> _cacheValid({required GetMaterialsAndCacheParams params}) async {
    try {
      SyncData syncData = await materialsRepository.getMaterialsSyncData(
          customerSAP: params.customerSAP);
      Duration diff = DateTime.now().difference(syncData.syncDateTime);

      if (diff.inMinutes < 30 && syncData.locale == params.locale) {
        return true;
      }
    } catch (e) {
      print('No materials cache');
    }
    return false;
  }
}

class GetMaterialsAndCacheParams {
  final String customerSAP;
  final bool hasConnection;
  final String locale;
  GetMaterialsAndCacheParams({
    required this.customerSAP,
    required this.hasConnection,
    required this.locale,
  });
}
