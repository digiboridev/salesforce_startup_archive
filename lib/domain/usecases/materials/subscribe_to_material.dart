import 'package:***REMOVED***/data/repositories/materials_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class SubscribeToMaterial implements UseCase<void, SubscribeToMaterialParams> {
  final MaterialsRepository materialsRepository;

  SubscribeToMaterial(this.materialsRepository);

  @override
  Future<void> call(SubscribeToMaterialParams params) async {
    return materialsRepository.subscribeToMaterial(
        customerSAP: params.customerSAP, materialNumber: params.materialNumber);
  }
}

class SubscribeToMaterialParams {
  final String customerSAP;
  final String materialNumber;
  SubscribeToMaterialParams({
    required this.customerSAP,
    required this.materialNumber,
  });
}
