import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/repositories/materials_repository.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetMaterialsAndCache
    implements UseCase<MaterialsCatalog, GetMaterialsAndCacheParams> {
  final MaterialsRepository materialsRepository;

  GetMaterialsAndCache(this.materialsRepository);

  @override
  Future<MaterialsCatalog> call(GetMaterialsAndCacheParams params) async {
    if (params.hasConnection) {
      try {
        MaterialsCatalog remoteMaterialsCatalog = await materialsRepository
            .getRemoteCatalog(customerSAP: params.customerSAP);

        materialsRepository.setLocalMaterials(
            customerSAP: params.customerSAP,
            materialsCatalog: remoteMaterialsCatalog);

        materialsRepository.setMaterialsSyncTime(
            customerSAP: params.customerSAP, dateTime: DateTime.now());
        return remoteMaterialsCatalog;
      } catch (e) {
        return _loadCache(customerSAP: params.customerSAP);
      }
    } else {
      return _loadCache(customerSAP: params.customerSAP);
    }
  }

  Future<MaterialsCatalog> _loadCache({required String customerSAP}) async {
    if (await _cacheUpToDate(customerSAP: customerSAP)) {
      return materialsRepository.getLocalMaterials(customerSAP: customerSAP);
    } else {
      throw InternalException(
          'Unable to load catalog for consumer $customerSAP');
    }
  }

  Future<bool> _cacheUpToDate({required String customerSAP}) async {
    try {
      DateTime lastSync = await materialsRepository.getMaterialsSyncTime(
          customerSAP: customerSAP);
      Duration diff = DateTime.now().difference(lastSync);

      if (diff.inMinutes < 30) {
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
  GetMaterialsAndCacheParams({
    required this.customerSAP,
    required this.hasConnection,
  });
}
