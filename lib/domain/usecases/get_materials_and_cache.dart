import 'package:***REMOVED***/data/repositories/materials_repository.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetMaterialsAndCache implements UseCase<MaterialsCatalog, String> {
  final MaterialsRepository materialsRepository;

  GetMaterialsAndCache(this.materialsRepository);

  @override
  Future<MaterialsCatalog> call(customerSAP) async {
    try {
      MaterialsCatalog remoteMaterialsCatalog =
          await materialsRepository.getRemoteCatalog(customerSAP: customerSAP);

      materialsRepository.setLocalMaterials(
          customerSAP: customerSAP, materialsCatalog: remoteMaterialsCatalog);

      materialsRepository.setMaterialsSyncTime(
          customerSAP: customerSAP, dateTime: DateTime.now());
      return remoteMaterialsCatalog;
    } catch (e) {
      print(e);
      try {
        MaterialsCatalog localMaterialsCatalog = await materialsRepository
            .getLocalMaterials(customerSAP: customerSAP);
        return localMaterialsCatalog;
      } catch (e) {
        throw Exception('Unable to load catalog for consumer $customerSAP');
      }
    }
  }
}
