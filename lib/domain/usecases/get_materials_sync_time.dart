import 'package:***REMOVED***/data/repositories/materials_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetMaterialsSyncTime implements UseCase<DateTime, String> {
  final MaterialsRepository materialsRepository;

  GetMaterialsSyncTime(this.materialsRepository);

  @override
  Future<DateTime> call(customerSAP) async {
    try {
      DateTime d = await materialsRepository.getMaterialsSyncTime(
          customerSAP: customerSAP);
      return d;
    } catch (e) {
      return DateTime(1994);
    }
  }
}
