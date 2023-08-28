import 'package:salesforce.startup/data/models/sync_data.dart';
import 'package:salesforce.startup/data/repositories/materials_repository.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class GetMaterialsSyncData implements UseCase<SyncData, String> {
  final MaterialsRepository materialsRepository;

  GetMaterialsSyncData(this.materialsRepository);

  @override
  Future<SyncData> call(customerSAP) async {
    SyncData d = await materialsRepository.getMaterialsSyncData(customerSAP: customerSAP);
    return d;
  }
}
